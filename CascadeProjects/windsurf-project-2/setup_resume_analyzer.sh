#!/bin/bash

# 📍 SETUP SCRIPT FOR ADVANCED RESUME ANALYZER

echo "🚀 Setting up AI Resume Analyzer with BERT NLP..."

# Check if virtual environment exists
if [ ! -d "backend/venv" ]; then
    echo "📦 Creating virtual environment..."
    cd backend
    python -m venv venv
    source venv/bin/activate
else
    echo "📦 Activating existing virtual environment..."
    cd backend
    source venv/bin/activate
fi

# Install dependencies
echo "📦 Installing dependencies..."
pip install -r requirements_new.txt

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p tpo/services
mkdir -p resume_analyses
mkdir -p logs

# Run migrations
echo "🗄️ Running database migrations..."
python manage.py makemigrations tpo
python manage.py migrate

# Create superuser if needed
echo "👤 Creating superuser (if needed)..."
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(email='admin@imrd.edu.in').exists():
    User.objects.create_superuser('admin@imrd.edu.in', 'admin123', first_name='Admin', last_name='User')
    print('✅ Admin user created')
else:
    print('✅ Admin user already exists')
EOF

# Collect static files
echo "📁 Collecting static files..."
python manage.py collectstatic --noinput

echo "✅ Setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Activate virtual environment: cd backend && source venv/bin/activate"
echo "2. Start Django server: python manage.py runserver"
echo "3. Start frontend: cd ../tpcell && npm start"
echo "4. Visit: http://localhost:3000"
echo ""
echo "🤖 AI Resume Analyzer is ready with BERT NLP capabilities!"
