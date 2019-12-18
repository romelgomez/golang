# GOROOT
export GOROOT=$HOME/go/tools/go
export PATH=$PATH:$GOROOT/bin

# GOPATH
LIBRARIES=$HOME/go/libraries
WORKSPACE=$HOME/go/workspace

export GOPATH=$LIBRARIES:$WORKSPACE

export PATH=$PATH:$LIBRARIES/bin:$WORKSPACE/bin
echo '

#[Golang].................................

# GOROOT
export GOROOT=$HOME/go/tools/go
export PATH=$PATH:$GOROOT/bin

# GOPATH
LIBRARIES=$HOME/go/libraries
WORKSPACE=$HOME/go/workspace

export GOPATH=$LIBRARIES:$WORKSPACE

export PATH=$PATH:$LIBRARIES/bin:$WORKSPACE/bin

#.................................[/Golang]
    
' >> ~/.profile && source ~/.profile

echo 'source ~/.profile' >> ~/.zshrc

echo 'source ~/.profile' >> ~/.bashrc