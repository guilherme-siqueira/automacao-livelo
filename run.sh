#!/bin/bash

web_image="browser_image"
robot_image="robot_image"

# alias para a rede que fará a comunicação entre os container 
network="network"

# alias para o endereço do container que rodará o navegador
browser_container="browser_container"

# alias para o endereço do container que rodará o Robot
robot_container="robot_container"

# pasta do projeto para compartilhar volume com o container do Robot
project_name=$(basename "$PWD")

function build_images {
    echo "=============================================================================="
    echo "Building Docker images"

    # browser image
    echo "------------------------------------------------------------------------------"
    echo $web_image
    docker build -q -f pipeline/web/dockerfile -t $web_image .

    # robot image
    echo "------------------------------------------------------------------------------"
    echo $robot_image
    docker build -q -f pipeline/robot/dockerfile -t $robot_image . 
}

function run_services {
    echo "=============================================================================="
    echo "Starting Docker services"

    # criar rede entre os containers
    echo "------------------------------------------------------------------------------"
    echo $network
    docker network create $network

    # criar container para o navegador
    echo "------------------------------------------------------------------------------"
    echo $browser_container
    docker run --net $network -p 5900:5900 -d --rm --name $browser_container $web_image

    # criar o container para o robot
    echo "------------------------------------------------------------------------------"
    echo $robot_container
    docker run --net $network --link=$browser_container -v $PWD:/$project_name -d --rm --name $robot_container $robot_image

    # tempinho pra garantir que a infraestrutura está realmente pronta para executar os testes
    sleep 5

    # iniciar os testes
    docker exec -it $robot_container robot --variable browser_container:$browser_container --outputdir $project_name/logs -- $project_name/tests
}

function stop_services {
    echo "=============================================================================="
    echo "Stopping Docker services"
    docker stop $robot_container
    docker stop $browser_container
    docker network rm $network
}

trap echo SIGINT

build_images

(run_services) || true && stop_services
