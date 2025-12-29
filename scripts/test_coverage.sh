echo "Generating test coverage report..."
pwd
cd ..
pwd

echo "Running tests with coverage..."
flutter test --coverage

echo "Generating HTML report from coverage data..."
genhtml coverage/lcov.info -o coverage/html

echo "Opening coverage report in browser..."
brew install lcov

open coverage/html/index.html