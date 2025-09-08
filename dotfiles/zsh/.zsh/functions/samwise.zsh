dbreset() {
    sudo -u postgres psql -d samwise_local_database -c "DROP SCHEMA IF EXISTS drizzle, public CASCADE; CREATE SCHEMA public; GRANT ALL ON SCHEMA public TO postgres, samwise_local_user;"
}
