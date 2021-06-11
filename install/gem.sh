packages=$(<data/gems.txt)

for package in $packages
do
    $dry gem install $package
done

# install jekyll
gem install --user-install bundler jekyll
