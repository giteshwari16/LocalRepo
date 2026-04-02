@echo off
echo 🚀 Setting up AI Resume Analyzer with BERT NLP...

REM Check if virtual environment exists
if not exist "backend\venv" (
    echo 📦 Creating virtual environment...
    cd backend
    python -m venv venv
    call venv\Scripts\activate
) else (
    echo 📦 Activating existing virtual environment...
    cd backend
    call venv\Scripts\activate
)

REM Install dependencies
echo 📦 Installing dependencies...
pip install -r requirements_new.txt

REM Create necessary directories
echo 📁 Creating directories...
if not exist "tpo\services" mkdir tpo\services
if not exist "resume_analyses" mkdir resume_analyses
if not exist "logs" mkdir logs

REM Run migrations
echo 🗄️ Running database migrations...
python manage.py makemigrations tpo
python manage.py migrate

REM Collect static files
echo 📁 Collecting static files...
python manage.py collectstatic --noinput

echo ✅ Setup complete!
echo.
echo 🎯 Next steps:
echo 1. Activate virtual environment: cd backend && venv\Scripts\activate
echo 2. Start Django server: python manage.py runserver
echo 3. Start frontend: cd ..\tpcell && npm start
echo 4. Visit: http://localhost:3000
echo.
echo 🤖 AI Resume Analyzer is ready with BERT NLP capabilities!
pause
