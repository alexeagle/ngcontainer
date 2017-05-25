git clone https://github.com/angular/closure-demo.git
cd closure-demo
yarn
yarn run build
xvfb-run -a yarn test
cd ..
git clone https://github.com/angular/tsickle.git
cd tsickle
git checkout bazel
bazel build ...

