#ifndef __MYSERVER_H__
#define __MYSERVER_H__

#include "../server/server.hpp"
#include "../server/route.hpp"

class MyServer : public Server 
{
    public:
      MyServer(int port = 5000);
};

#endif /* __MYSERVER_H__ */