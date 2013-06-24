coredev.vagrant
================

coredev.vagrant is a kit for setting up a Plone coredev developmentenvironment in a virtual box.

The kit uses the VirtualBox for the virtual machine and the Vagrant box setup system.
It should run on any host machine for which Vagrant is available; that includes Windows Vista+, OS X and Linux.
Both VirtualBox and Vagrant are open-source.

The coredev.vagrant kit is meant to get you to your first commit quickly.
Key development files are set up to be accessible and editable with host-based editors.
A host command script is provided to run buildout and anything else in the buildout's bin.
So little or no knowledge of the VirtualBox guest environment (which happens to be Ubuntu Linux) should be required.

Installation
------------

1. Install VirtualBox: https://www.virtualbox.org

2. Install Vagrant: http://www.vagrantup.com

3. If you are using Windows, install the Putty ssh kit: http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html. Install all the binaries, or at least putty.exe and plink.exe.

4. Download and unpack coredev.vagrant from https://github.com/plone/coredev.vagrant/archive/master.zip.

5. If you're running on Windows, look inside the unpack directory. Look for the innermost coredev.vagrant_master directory and move it to somewhere where it will have a much shorter pathname. We're going to create some directories that are shared between host and guest systems, and Windows path-length limitations are going to bite you if your full pathnames are long.

6. Open a command prompt; change directory into the coredev.vagrant-master directory and issue the command "vagrant up".

7. Go for lunch or a long coffee break. "vagrant up" is going to download a virtual box kit (unless you already happen to have a match installed), clone buildout.coredev and set up some convenience scripts. On Windows, it will also generate an ssh key pair that's usable with Putty.

8. Look to see if the install ran well. The virtual machine will be running at this point.

While running "vagrant up", feel free to ignore messages like "stdin: is not a tty" and "warning: Could not retrieve fact fqdn". They have no significance in this context.

Using the Vagrant-installed VirtualBox
--------------------------------------

The sample prompts below are for Windows. Linux/BSD/OS X commands are identical.

You may now start and stop the virtual machine by issuing command in the same directory::

    c:\...> vagrant suspend

stops the virtual machine, saving an image of its state so that you may later restart with::

    c:\...> vagrant resume

Run "vagrant" with no command line arguments to see what else you can do.

Finally, you may remove the VirtualBox (deleting its image) with the command::

    c:\...> vagrant destroy

Note that port 8080 on the host system will be in use whenever the guest system is up. Halt it to clear the port.

Running Plone and buildout
--------------------------

The sample commands below are for Windows. Linux/BSD/OS X users will need to use commands like "./runbin.sh".

To run buildout, just issue the command "runbin buildout" (./runbin.sh on a Unix-workalike host). This will run buildout; add command line arguments as desired::

    c:\...> runbin buildout

Expect your first coredev buildout to take some time. It may even timeout. Just run again until it finishes. Subsequent builds will be faster.

To start Plone in the foreground (so its messages run to the command window), use the command::

    c:\...> runbin instance fg

Note that you will not be able to run Plone until you've run buildout. This is different from plonedev-vagrant.

Plone will be connected to port 8080 on the host machine, so that you should be able to crank up a web browser, point it at http://localhost:8080 and see Zope/Plone.

Plone is installed with an administrative user with id "admin" and password "admin".

Stop foreground Plone by using the site-setup maintenance stop button or by just pressing ctrl-c.

If you use ctrl-c, you've got a little cleanup to do. Plone will still be running on the virtual box. Kill it with the command::

    c:\...> kill_plone

To run a test suite, use a command like::

    c:\...> runbin test -s plonetheme.sunburst

Editing Plone configuration and source files
--------------------------------------------

After running "vagrant up", you should have a buildout.coredev subdirectory. In it, you'll find your buildout configuration files and a "src" directory. These are the matching items from a normal coredev installation. You may edit all the files.

All of this is happening in a directory that is shared with the guest operating system, and the .cfg files and src directory are linked back to the working copy of coredev on the guest machine. All the rest of the install is on the guest system only.

Using the VirtualBox directly
-----------------------------

How you get a command prompt on your "guest" machine will depend on your host operating system. On Unix workalikes, use the command::

    $ vagrant ssh

If your host OS is Windows, use::

    c:\...> putty_ssh

The "putty_ssh command" runs the Putty SSH program using command line parameters that connect to the virtual machine at port 2222 and use a special ssh key created for putty. That key, by the way, is created and stored in a way that is not password-protected, so it should not be regarded as adequately secured for any sensitive purpose.

For Windows users, we also have a convenience wrapper around pscp, the putty version of secure copy. To copy from the host to the guest::

    c:\...> putty_scp myfile.cfg vagrant@localhost:.

Or, the guest to the host::

    c:\...> putty_scp -r vagrant@localhost:Plone/zinstance/var .

The "vagrant@localhost:" specifies the vagrant user on the guest machine.

Making commits
--------------

To use git, you'll need to use vagrant ssh to get a command prompt on the guest OS.
Typically, you'll change into the buildout.coredev directory and run commit or push commands::

    c:\...> putty_ssh  # on Unix-workalikes, "vagrant ssh"
    cd buildout.coredev
    git commit ...
    git push

Before committing for the first time, run:

    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"

buildout.coredev is checked out with an https URL. So, you'll need to supply a username
and password each time you push. If you don't like that, learn how to use ssh keys change the buildout.coredev clone to use and ssh remote.

What doesn't work
-----------------

Using "runbin instance debug" from the host side isn't going to work. However, you may use your ssh command to get a guest OS prompt and run it there. You'll just need to know a little about how to operate at a Linux "bash" command prompt.

The same is true for anything else that requires command-line interaction.

What's under the hood
---------------------

VirtualBox provides the virtual machine facilities. Vagrant makes setting it up, including port forwarding and shared folders, convenient. Vagrant also provides a wrapper around the Puppet and shell provisioning system.

The guest operating system is the most recent Ubuntu LTS (12.0.4, Precise Pangolin), 32-bit (so that it will run on a 32- or 64-bit host).

After setting up the operating system, Vagrant's provisioning system is used to load the required system packages, clone buildout.coredeve, and set up the convenience scripts and share directory.

Problems or suggestions?
------------------------

File a ticket at https://github.com/smcmahon/coredev.vagrant/issues. If this kit becomes mainstream, the tracker will move to http://dev.plone.org.

Steve McMahon, steve@dcn.org

License
-------

Code included with this kit is licensed under the MIT Licence, http://opensource.org/licenses/MIT. Documentation is CC Attribution Unported, http://creativecommons.org/licenses/by/3.0/.
