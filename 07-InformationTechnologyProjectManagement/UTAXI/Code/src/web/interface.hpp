#ifndef __INTERFACE_H__
#define __INTERFACE_H__

#include "myserver.hpp"
#include "utaxi.hpp"

class Interface
{
    public:
        void run(char *argv[]);

    private:
        Utaxi *utaxi;
        void server_pages(MyServer &server);
        void server_css(MyServer &server);
        void server_js(MyServer &server);
        void server_images(MyServer &server);
        void server_handlers(MyServer &server);
        class SignupPageHandler : public RequestHandler
        {
            public:
                SignupPageHandler();
                Response *callback(Request *req);
        };

        class SignupHandler : public RequestHandler
        {
            public:
                SignupHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class ReqTripPageHandler : public RequestHandler
        {
            public:
                ReqTripPageHandler();
                Response *callback(Request *req);
        };

        class ShowReqTripHandler : public RequestHandler
        {
            public: ShowReqTripHandler(Utaxi *utaxi_);
                    Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class ReqTripHandler : public RequestHandler
        {
            public:
                ReqTripHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class CancelTripPageHandler : public RequestHandler
        {
            public:
                CancelTripPageHandler();
                Response *callback(Request *req);
        };

        class CancelTripHandler : public RequestHandler
        {
            public:
                CancelTripHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class FinishTripPageHandler : public RequestHandler
        {
            public:
                FinishTripPageHandler();
                Response *callback(Request *req);
        };

        class FinishTripHandler : public RequestHandler
        {
            public:
                FinishTripHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class ReqTripsListPageHandler : public RequestHandler
        {
            public:
                ReqTripsListPageHandler();
                Response *callback(Request *req);
        };

        class ReqTripsListHandler : public RequestHandler
        {
            public:
                ReqTripsListHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class TripsListPageHandler : public RequestHandler
        {
            public:
                TripsListPageHandler();
                Response *callback(Request *req);
        };

        class ShowTripsListHandler : public RequestHandler
        {
            public:
                ShowTripsListHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class AcceptTripHandler : public RequestHandler
        {
            public:
                AcceptTripHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

        class SaveDataHandler : public RequestHandler
        {
            public:
                SaveDataHandler(Utaxi *utaxi_);
                Response *callback(Request *req);
            private:
                Utaxi *utaxi;
        };

};

#endif /* __INTERFACE_H__ */