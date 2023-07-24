#include "rsdl.hpp"
#include <exception>
#include <iostream>
#include <sstream>

using namespace std;

void delay(int millisecond) { SDL_Delay(millisecond); }

Event::Event() {}

Event::Event(SDL_Event _sdl_event) { sdl_event = _sdl_event; }

Event::EventType Event::get_type() const {
  SDL_Event e = sdl_event;
  try {
    if (e.type == SDL_QUIT)
      return QUIT;
    if (e.type == SDL_MOUSEBUTTONDOWN && e.button.button == SDL_BUTTON_LEFT)
      return LCLICK;
    if (e.type == SDL_MOUSEBUTTONDOWN && e.button.button == SDL_BUTTON_RIGHT)
      return RCLICK;
    if (e.type == SDL_KEYDOWN && e.key.repeat == 0)
      return KEY_PRESS;
    if (e.type == SDL_KEYUP)
      return KEY_RELEASE;
    if (e.type == SDL_MOUSEBUTTONUP && e.button.button == SDL_BUTTON_LEFT)
      return LRELEASE;
    if (e.type == SDL_MOUSEBUTTONUP && e.button.button == SDL_BUTTON_RIGHT)
      return RRELEASE;
    if (e.type == SDL_MOUSEBUTTONUP && e.button.button == SDL_BUTTON_RIGHT)
      return RRELEASE;
    if (e.type == SDL_MOUSEMOTION)
      return MMOTION;
  } catch (...) {
    return NA;
  }
  return NA;
}

Point Event::get_mouse_position() const {
  switch (get_type()) {
  case MMOTION:
    return Point(sdl_event.motion.x, sdl_event.motion.y);
  case LCLICK:
  case RCLICK:
  case LRELEASE:
  case RRELEASE:
    return Point(sdl_event.button.x, sdl_event.button.y);
  default:
    throw runtime_error("Invalid Event Type");
  }
}

Point get_current_mouse_position() {
  Point ret(0, 0);
  SDL_GetMouseState(&ret.x, &ret.y);
  return ret;
}

Point Event::get_relative_mouse_position() const {
  switch (get_type()) {
  case MMOTION:
    return Point(sdl_event.motion.x, sdl_event.motion.y);
  default:
    return Point(0, 0);
  }
}

char Event::get_pressed_key() const {
  if (get_type() != KEY_PRESS && get_type() != KEY_RELEASE)
    return -1;
  return (char)sdl_event.key.keysym.sym;
}

void Window::init() {
  if (SDL_Init(0) < 0)
    throw runtime_error("SDL Init Fail");
  int flags = (SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_AUDIO);
  if (SDL_WasInit(flags) != 0)
    throw runtime_error(string("SDL_WasInit Failed.") + SDL_GetError());
  if (SDL_InitSubSystem(flags) < 0)
    throw runtime_error(string("SDL_InitSubSystem Failed.") + SDL_GetError());
  if (!(IMG_Init(IMG_INIT_PNG) & IMG_INIT_PNG))
    throw runtime_error("IMG_Init Fail");
  if (TTF_Init() == -1)
    throw runtime_error("TTF_Init Fail");
  if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 2048) < 0)
    throw runtime_error(
        string("SDL_mixer could not initialize. SDL_mixer Error:") +
        Mix_GetError());
}

Window::Window(int _width, int _height, std::string title)
    : width(_width), height(_height) {
  init();
  SDL_CreateWindowAndRenderer(width, height, 0, &win, &renderer);
  if (win == NULL || renderer == NULL)
    throw runtime_error(string("Window could not be created! SDL_Error: ") +
                        SDL_GetError());
  SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1");
  SDL_SetWindowTitle(win, title.c_str());
  update_screen();

  music = NULL;

  // The following line of code was added to remedy the problem where 
  // the SDL window would malfunction for approximately the first 5ms 
  // after creation. it appears that the window requires some time to
  // set up, and the 10ms delay seems to solve the problem consistently.
  delay(10);
}

Window::~Window() {
  SDL_DestroyWindow(win);
  if (TTF_WasInit())
    TTF_Quit();
  if (music != NULL)
    Mix_FreeMusic(music);

  map<string, Mix_Chunk *>::iterator chunk_it;
  for (chunk_it = sound_effects_cache.begin();
       chunk_it != sound_effects_cache.end(); ++chunk_it) {
    Mix_FreeChunk(chunk_it->second);
  }

  Mix_Quit();
  SDL_Quit();
}

Window &Window::operator=(const Window &window) {
  width = window.width;
  height = window.height;
  return *this;
}

void Window::show_text(string input, Point src, RGB color, string font_addr,
                       int size) {
  SDL_Color textColor = {
      color.red,
      color.green,
      color.blue,
  };
  stringstream ss;
  ss << size;
  TTF_Font *font = fonts_cache[font_addr + ":" + ss.str()];
  if (font == NULL) {
    font = TTF_OpenFont(font_addr.c_str(), size);
    fonts_cache[font_addr + ":" + ss.str()] = font;
    if (font == NULL)
      throw runtime_error("Font not found: " + font_addr);
  }
  SDL_Surface *textSurface =
      TTF_RenderText_Solid(font, input.c_str(), textColor);
  SDL_Texture *text = SDL_CreateTextureFromSurface(renderer, textSurface);
  SDL_Rect renderQuad = {src.x, src.y, textSurface->w, textSurface->h};
  SDL_RenderCopy(renderer, text, NULL, &renderQuad);
  SDL_DestroyTexture(text);
  SDL_FreeSurface(textSurface);
}

void Window::set_color(RGB color) {
  SDL_SetRenderDrawColor(renderer, color.red, color.green, color.blue, 255);
}

void Window::clear() {
  SDL_SetRenderDrawColor(renderer, 0, 0, 0, 0);
  SDL_RenderClear(renderer);
}

void Window::draw_img(string filename, Rectangle dst, Rectangle src,
                      double angle, bool flip_horizontal, bool flip_vertical) {
  SDL_Texture *res = texture_cache[filename];
  if (res == NULL) {
    res = IMG_LoadTexture(renderer, filename.c_str());
    if (res == NULL)
      throw runtime_error("Failed to load image: \"" + filename + "\". " +
                          "make sure you are using the correct address.");
    texture_cache[filename] = res;
  }
  SDL_RendererFlip flip = (SDL_RendererFlip)(
      (flip_horizontal ? SDL_FLIP_HORIZONTAL : SDL_FLIP_NONE) |
      (flip_vertical ? SDL_FLIP_VERTICAL : SDL_FLIP_NONE));

  SDL_Rect sdl_dst = {dst.x, dst.y, dst.w, dst.h};
  SDL_Rect *dst_ptr = (dst == NULL_RECT ? NULL : &sdl_dst);

  SDL_Rect sdl_src = {src.x, src.y, src.w, src.h};
  SDL_Rect *src_ptr = (src == NULL_RECT ? NULL : &sdl_src);

  SDL_RenderCopyEx(renderer, res, src_ptr, dst_ptr, angle, NULL, flip);
}

void Window::update_screen() { SDL_RenderPresent(renderer); }

void Window::fill_rect(Rectangle rect, RGB color) {
  set_color(color);
  SDL_Rect r = {rect.x, rect.y, rect.w, rect.h};
  SDL_RenderFillRect(renderer, &r);
}

void Window::draw_line(Point src, Point dst, RGB color) {
  set_color(color);
  SDL_RenderDrawLine(renderer, src.x, src.y, dst.x, dst.y);
}

void Window::draw_point(Point p, RGB color) {
  set_color(color);
  SDL_RenderDrawPoint(renderer, p.x, p.y);
}

void Window::draw_rect(Rectangle rect, RGB color, unsigned int line_width) {
  Point top_left = Point(rect.x, rect.y);
  Point bottom_right = Point(rect.x + rect.w, rect.y + rect.h);
  for (size_t i = 0; i < line_width; i++) {
    draw_line(top_left + Point(i, i), top_left + Point(rect.w - i, i), color);
    draw_line(top_left + Point(i, i), top_left + Point(i, rect.h - i), color);
    draw_line(top_left + Point(i, rect.h - i), bottom_right - Point(i, i),
              color);
    draw_line(top_left + Point(rect.w - i, i), bottom_right - Point(i, i),
              color);
  }
}

void Window::fill_circle(Point center, int r, RGB color) {
  float tx, ty;
  float xr;
  set_color(color);
  for (ty = (float)-SDL_fabs(r); ty <= (float)SDL_fabs((int)r); ty++) {
    xr = (float)SDL_sqrt(r * r - ty * ty);
    if (r > 0) { /* r > 0 ==> filled circle */
      for (tx = -xr + .5f; tx <= xr - .5; tx++) {
        draw_point(center + Point(tx, ty), color);
      }
    } else {
      draw_point(center + Point(-xr + .5f, ty), color);
      draw_point(center + Point(+xr - .5f, ty), color);
    }
  }
}

bool Window::has_pending_event() { return SDL_PollEvent(NULL); }

Event Window::poll_for_event() {
  SDL_Event event;
  while (SDL_PollEvent(&event) != 0) {
    Event e(event);
    if (e.get_type() != Event::NA)
      return e;
  }
  return event;
}

RGB::RGB(int r, int g, int b) {
  if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255)
    throw logic_error("Invalid RGB Color");
  red = r;
  green = g;
  blue = b;
}

Point::Point(int _x, int _y) : x(_x), y(_y) {}

void Window::dump_err() { cerr << SDL_GetError() << endl; }

void Window::play_music(string filename) {
  if (filename == music_filename) {
    if (Mix_PausedMusic() == 1) {
      Mix_ResumeMusic();
    } else {
      Mix_HaltMusic();
      Mix_PlayMusic(music, -1);
    }
  } else {
    music_filename = filename;
    if (Mix_PlayingMusic() == 1) {
      Mix_HaltMusic();
      Mix_FreeMusic(music);
    }
    music = Mix_LoadMUS(music_filename.c_str());
    if (music == NULL)
      throw runtime_error(string("Failed to load music. SDL_mixer Error:") +
                          Mix_GetError());
    Mix_PlayMusic(music, -1);
  }
}

void Window::pause_music() {
  if (Mix_PlayingMusic() == 1)
    Mix_PauseMusic();
}

void Window::stop_music() {
  Mix_HaltMusic();
  Mix_FreeMusic(music);
  music = NULL;
  music_filename = "";
}

void Window::play_sound_effect(std::string filename) {
  Mix_Chunk *chunk = sound_effects_cache[filename];
  if (chunk == NULL) {
    chunk = Mix_LoadWAV(filename.c_str());
    if (chunk == NULL)
      throw runtime_error(
          string("Failed to load sound effect: ") + filename +
          "Please make sure you are using the correct address.");
    sound_effects_cache[filename] = chunk;
  }
  Mix_PlayChannel(-1, chunk, 0);
}

void Window::resume_music() { Mix_ResumeMusic(); }

Point Point::operator+(const Point p) const { return Point(x + p.x, y + p.y); }

Point Point::operator-(const Point p) const { return (*this) + (-1) * p; }

Point Point::operator*(const int c) const { return Point(x * c, y * c); }

Point Point::operator/(const int c) const { return Point(x / c, y / c); }

Point operator*(const int c, const Point p) { return p * c; }

Point &Point::operator+=(const Point p) {
  (*this) = (*this) + p;
  return (*this);
}

Point &Point::operator-=(const Point p) {
  (*this) = (*this) - p;
  return (*this);
}

Point &Point::operator*=(const int c) {
  (*this) = (*this) * c;
  return (*this);
}

Point &Point::operator/=(const int c) {
  (*this) = (*this) / c;
  return (*this);
}

Point::operator SDL_Point() {
  SDL_Point ret;
  ret.x = x;
  ret.y = y;
  return ret;
}

ostream &operator<<(ostream &stream, const Point p) {
  stream << '(' << p.x << ", " << p.y << ')';
  return stream;
}

Rectangle::Rectangle(int _x, int _y, int _w, int _h) { init(_x, _y, _w, _h); }

Rectangle::Rectangle(Point top_left, Point bottom_right) {
  init(top_left.x, top_left.y, bottom_right.x - top_left.x,
       bottom_right.y - top_left.y);
}

Rectangle::Rectangle(Point top_left, int w, int h) {
  init(top_left.x, top_left.y, w, h);
}

void Rectangle::init(int _x, int _y, int _w, int _h) {
  x = _x;
  y = _y;
  w = _w;
  h = _h;
}

Rectangle NULL_RECT(-1, -1, -1, -1);

bool Rectangle::operator==(const Rectangle &r) {
  return x == r.x && y == r.y && w == r.w && h == r.h;
}

std::ostream &operator<<(std::ostream &stream, const Rectangle r) {
  stream << "(x: " << r.x << ", y: " << r.y << ", w: " << r.w << ", h: " << r.h
         << ")";
  return stream;
}
