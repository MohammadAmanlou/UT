#include "interface.hpp"

void Interface::run(char *argv[])
{
    utaxi = new Utaxi;
    
    while(1)
    {
        MyServer server(5000);
        try
        {
            server_pages(server);
            server_css(server);
            server_js(server);
            server_images(server);
            server_handlers(server);
            server.setNotFoundErrPage("static/404.html");
            server.run();
        }
        catch(std::runtime_error& er)
        {
            std::cerr << er.what() << std::endl;
        }
    }
}