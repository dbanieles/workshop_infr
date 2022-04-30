
# Docker network brdge

    docker pull busybox
    docker run -dit --name busybox1 busybox /bin/sh
    docker run -dit --name busybox2 busybox /bin/sh
    docker network inspect bridge
    docker attach busybox1

# Docker network host



# Docker traffic generator

    docker run stress-test-container
    attach shell
    bin/sh
    for i in `seq 1 10000`; do curl -s http://svc-restapi:8080/health; done