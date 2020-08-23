echo "..:: Setting the environment variables \n"

if [[ -z "$GOROOT" ]] || [[ -z "$GOPATH" ]]; then

echo '

export GOROOT=$HOME/go/tools/go
export GOPATH=$HOME/go/libraries:$HOME/go/workspace
export PATH=$PATH:$GOROOT/bin:$HOME/go/libraries/bin:$HOME/go/workspace/bin

' >> ~/.profile && source ~/.profile

echo 'source ~/.profile' >> ~/.zshrc
echo 'source ~/.profile' >> ~/.bashrc

fi
