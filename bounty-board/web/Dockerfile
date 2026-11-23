# The web service's image: nginx, with the page and nginx's settings.

# Start from the official nginx image, a web server.
FROM nginx:1.29-alpine
# nginx's settings: serve the page, and pass /api/ calls on to the api service.
# nginx reads every .conf file in /etc/nginx/conf.d/.
COPY default.conf /etc/nginx/conf.d/default.conf
# The page itself, in the folder nginx serves files from.
COPY index.html /usr/share/nginx/html/index.html
