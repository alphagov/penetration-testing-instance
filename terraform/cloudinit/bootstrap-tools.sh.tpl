    #!/usr/bin/env bash
    set -euo pipefail

    echo "Starting Bootstrapping"
    apt-get update
    apt-get -y install gobuster
    apt-get -y install seclists
    pip install requests==2.5
    pip install urllib3==1.22
    cd /root/Downloads/
    curl -s https://api.github.com/repos/codingo/NoSQLMap/releases/latest | grep tarball | cut -d '"' -f 4 | wget -O nosqlmap.tar -qi -
    tar xf nosqlmap.tar
    cd coding*
    python setup.py install
    cd /root/Downloads/
    curl -s https://api.github.com/repos/EmpireProject/Empire/releases/latest | grep tarball | cut -d '"' -f 4 | wget -O empire.tar -qi -
    tar xf empire.tar
    cd Empir*
    ./setup/install.sh <<< "y"
    echo "Bootstrapping Complete"
    exit 0
