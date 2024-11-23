Sync Changes with Docker Compose

To sync changes between your local machine and the Docker container using a volume mount, we will use Docker Compose’s volumes option. This allows the local directory (where your hello.cpp resides) to be mounted into the container so that edits you make locally are immediately reflected in the container.

Updated Files

Dockerfile

This Dockerfile starts a bash shell to allow manual compilation and execution of the C++ program:

FROM gcc:latest
WORKDIR /usr/src/app
CMD ["bash"]

docker-compose.yml

Add a volume mount to sync the local directory (.) with the container’s working directory (/usr/src/app):

version: "3.9"
services:
  cpp-app:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - .:/usr/src/app  # Sync local directory to container directory
    working_dir: /usr/src/app
    stdin_open: true  # Keep the container open for interactive use
    tty: true         # Enable an interactive terminal

hello.cpp

Your example C++ program:

#include <iostream>

int main() {
    std::cout << "Hello, Docker with synced C++ changes!" << std::endl;
    return 0;
}

Save this file as hello.cpp in the same directory as the Dockerfile and docker-compose.yml.

Steps to Use Docker Compose with Volume Mount

	1.	Build the Docker Image:

docker-compose build


	2.	Start the Container:

docker-compose up -d


	3.	Access the Container:

docker exec -it <container_name> bash

Replace <container_name> with the name of the container. To find the name, run:

docker ps


	4.	Compile and Run the Program:
Inside the container:

g++ -o hello hello.cpp
./hello


	5.	Edit and Sync Changes:
	•	Edit hello.cpp on your local machine.
	•	Recompile and rerun inside the container:

g++ -o hello hello.cpp
./hello



Verify Changes Sync

Make a change in hello.cpp, such as updating the output message:

#include <iostream>

int main() {
    std::cout << "Hello, Docker with updated synced changes!" << std::endl;
    return 0;
}

Recompile and run inside the container:

g++ -o hello hello.cpp
./hello

Output:

Hello, Docker with updated synced changes!

Why This Works

	•	Volumes (.:/usr/src/app): The . refers to the current local directory, and /usr/src/app is the directory inside the container. Any changes made locally are immediately reflected in the container.
	•	Container Workflow: You can keep the container running while editing files locally and recompile as needed inside the container.

This setup ensures seamless syncing for efficient development.
