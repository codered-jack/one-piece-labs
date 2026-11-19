import os
from http.server import BaseHTTPRequestHandler, HTTPServer

port = int(os.environ.get("PORT", "8000"))  # PORT if it's set, otherwise 8000


class Ahoy(BaseHTTPRequestHandler):
    def do_GET(self):
        body = f"Ahoy from port {port}!\n".encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


print(f"Listening on port {port}", flush=True)
HTTPServer(("", port), Ahoy).serve_forever()
