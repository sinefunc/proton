Setup

    command git clone git@github.com:sinefunc/proton.git -b site     site/
    command git clone git@github.com:sinefunc/proton.git -b gh-pages site/_public

Do

    gem install proton
    rake build
    rake deploy
