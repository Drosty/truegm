# truegm

Welcome to the truegm vagrant VM.

If this is your first time running the VM, there are a few steps you must take to the application up and running.

You may also need to perform these steps periodically throughout the development cycle.

1. The application lives in ~/truegm. Go there: $ cd truegm
2. Install the gem bundle: $ bundle install
3. Migrate the database: $ brake db:schema:load
4. Seed the database: $ brake db:seed
5. Start the server: $ forman start

Congratulations! You should now be able to access the application at http://localhost:5000/ from your host OS.

## Performance

If I/O performance is poor with vagrant shared filesystems, you may try to run the ~/bin/setup_native.sh script
to install the truegm app natively on your guest vm.
