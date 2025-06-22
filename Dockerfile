
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Clean default nginx page
RUN rm -rf ./*

# Copy static files into nginx HTML root
COPY index.html styles.css ./

# Optional: Copy a custom nginx config if you have one
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Run NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]
