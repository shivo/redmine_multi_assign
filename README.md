# redmine multi assign

Plugin for Redmine that allows to assign multiple projects and
subprojects to user at once.

## Installation

Just go to vendor/plugins directory and clone this project from github:

    git clone https://github.com/shivo/redmine_multi_assign.git

Then restart redmine server.

## Usage

Go to the Administration -> Users -> edit desired user -> Projects tab.

On the right side there is a tree of available projects and subprojects. Here you can
check/uncheck all projects at once with 'Check all' and 'Uncheck all' links. Also you
can check individual projects with corresponding checkboxes.

After desired projects are checked, you can choose a user roles to assign
in the roles section below. Then you hit 'Add' button, and you are done!

Now look on the left side of the view. Here is the list of assigned projects through user roles.
First you can check the projects you want to delete or edit. Again check/uncheck all projects 
with buttons or check projects with checkboxes. Next, choose one of the actions above. These are
either 'Delete' or 'Edit'. 

With 'Delete' you will unassign all user roles from corresponding projects.

When you choose 'Edit', another form with user roles will roll up. Here you can check the roles you want
to have assigned to the project and uncheck the ones you don't want to have assigned.

Finally, hit the 'Submit' button.

And that's all.

## Warning

This plugin was tested in production environment, but this does not mean its bug free. Use with care!

## Note

Tested only with redmine 1.3.x

## Licensing

This plugin is open-source and licensed under the "GNU General Public License v2" (GPL, http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
). See the included GPL.txt and LICENSE.txt files for details.

(C)2012 Juraj Sujan aka shivo for AXON PRO s.r.o.

