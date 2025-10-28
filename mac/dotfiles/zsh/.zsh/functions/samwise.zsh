dbreset() {
    sudo -u postgres psql -d samwise_local_database -c "DROP SCHEMA IF EXISTS drizzle, public CASCADE; CREATE SCHEMA public; GRANT ALL ON SCHEMA public TO postgres, samwise_local_user;"
}

lambda() {
    if [ -z "$1" ]; then
        echo "Usage: lambda <function-name>"
        return 1
    fi

    aws lambda invoke --profile samwise-aws-nonprod --region us-east-1 --payload {} --function-name "$1" response.json
}

migrate-demo() {
    lambda samwise-psm-staging-dbmigrateFunction-bcucvrum
}

migrate-prod() {
    lambda samwise-psm-production-dbmigrateFunction-vecwfrrv
}
