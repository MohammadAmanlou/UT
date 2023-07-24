#ifndef __RSDL_H__
#define __RSDL_H__

#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <SDL2/SDL_mixer.h>
#include <SDL2/SDL_ttf.h>

#include <cstdlib>
#include <iostream>
#include <map>
#include <stdexcept>
#include <string>

struct Point {
  Point(int x, int y);
  Point() = default;
  int x;
  int y;
  Point operator+(const Point) const;
  Point operator-(const Point) const;
  Point operator*(const int)const;
  Point operator/(const int) const;
  Point &operator+=(const Point);
  Point &operator-=(const Point);
  Point &operator*=(const int);
  Point &operator/=(const int);
  operator SDL_Point();
};
Point operator*(const int, const Point);
std::ostream &operator<<(std::ostream &stream, const Point);

struct Rectangle {
  Rectangle(int x, int y, int w, int h);
  Rectangle(Point top_left, Point bottom_right);
  Rectangle(Point top_left, int w, int h);
  bool operator==(const Rectangle &);

  int x, y, w, h;

private:
  void init(int x, int y, int w, int h);
};
std::ostream &operator<<(std::ostream &stream, const Rectangle);

extern Rectangle NULL_RECT;

struct RGB {
  RGB(int r, int g, int b);
  Uint8 red;
  Uint8 green;
  Uint8 blue;
};

const RGB WHITE(255, 255, 255);
const RGB YELLOW(255, 255, 0);
const RGB MAGENTA(255, 0, 255);
const RGB RED(255, 0, 0);
const RGB CYAN(0, 255, 255);
const RGB GREEN(0, 255, 0);
const RGB BLUE(0, 0, 255);
const RGB BLACK(0, 0, 0);

class Event {
public:
  Event();
  Event(SDL_Event _sdl_event);
  enum EventType {
    NA,
    LCLICK,
    RCLICK,
    LRELEASE,
    RRELEASE,
    MMOTION,
    KEY_PRESS,
    KEY_RELEASE,
    QUIT,
    NO_EVENT
  };
  EventType get_type() const;
  Point get_mouse_position() const;
  Point get_relative_mouse_position() const;
  char get_pressed_key() const;

protected:
  SDL_Event sdl_event;
};

class Window {
public:
  Window(int width = 640, int height = 480, std::string title = "RSDL");
  ~Window();
  Window &operator=(const Window &);
  void draw_img(std::string filename, Rectangle dst = NULL_RECT,
                Rectangle src = NULL_RECT, double angle = 0,
                bool flip_horizontal = false, bool flip_vertical = false);
  void show_text(std::string input, Point src, RGB color = WHITE,
                 std::string font_addr = "FreeSans.ttf", int size = 24);
  void draw_point(Point, RGB color = WHITE);
  void draw_line(Point src, Point dst, RGB color = WHITE);
  void draw_rect(Rectangle rect, RGB color = WHITE,
                 unsigned int line_width = 4);
  void fill_rect(Rectangle rect, RGB color = WHITE);
  void fill_circle(Point center, int radius, RGB color = WHITE);
  void update_screen();
  void clear();
  bool has_pending_event();
  Event poll_for_event();
  void dump_err();
  int get_height() const { return height; }
  int get_width() const { return width; }
  void play_music(std::string filename);
  void pause_music();
  void resume_music();
  void stop_music();
  void play_sound_effect(std::string filename);

protected:
  int width, height;
  SDL_Window *win;
  SDL_Renderer *renderer;
  Mix_Music *music;
  std::string music_filename;
  std::map<std::string, SDL_Texture *> texture_cache;
  std::map<std::string, TTF_Font *> fonts_cache;
  std::map<std::string, Mix_Chunk *> sound_effects_cache;
  void set_color(RGB color);
  void init();
};

void delay(int millisecond);
Point get_current_mouse_position();

#endif
