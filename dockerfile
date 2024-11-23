# # Use the official GCC image from Docker Hub as the base image
# FROM gcc:latest
# # Set the working directory in the container
# WORKDIR /usr/src/app
# # Copy the C source code file to the working directory
# COPY hello.c .
# # Compile the C program
# RUN gcc -o hello hello.c
# # Command to run the compiled program
# CMD ["./hello"]

# ----
# FROM gcc:latest
# WORKDIR /usr/src/app
# CMD ["bash"]  # Start with a bash shell

FROM gcc:latest
WORKDIR /usr/src/app
CMD ["bash"]
