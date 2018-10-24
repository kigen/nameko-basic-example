from nameko.rpc import rpc, RpcProxy

from nameko.timer import timer
from nameko.web.handlers import http
import logging
from nameko.events import EventDispatcher, event_handler


class EchoService:
    name = "echo_service"

    @rpc
    def hello_world(self, name):
        return "Hello, {}!".format(name)
    
    @rpc
    def pong(self, message):
        logging.info("ping-pong: {0}".format(message))
        if message == "ping":
            return "pong!"

    @event_handler("ping_service", "harambee")
    def nyayo(self, message):
        logging.info("harambee-nyayo: {0}".format(message))
        logging.info("harambee-nyayo:  Nyayo!!")



class PingService:
    name = "ping_service"
    echo = RpcProxy("echo_service")
    event = EventDispatcher()

    @http('GET', '/hello')
    def hello(self, request):
        message = self.echo.hello_world("World!")
        return message

    @timer(interval=10)
    def timer(self):
        pong = self.echo.pong("ping")
        logging.info("ping-pong: {0}".format(pong))
        
        logging.info("harambee-nyayo: Invoking event")
        self.event("harambee", "Harambee!!")

