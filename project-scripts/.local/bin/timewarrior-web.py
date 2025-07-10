#!/usr/bin/env -S mise x python@3.11 -- python

import subprocess

from nicegui import ui


# Function to get recent tags from Timewarrior
def get_recent_tags():
    try:
        # Run the Timewarrior command to get tags
        result = subprocess.run(['timew', 'tags'], capture_output=True, text=True)
        # Split the output into lines and return as a list of tags
        tags = result.stdout.splitlines()
        return [tag[:-2].strip() for tag in tags if tag.strip()]
    except Exception as e:
        ui.notify(f'An error occurred while fetching tags: {e}', color='red')
        return []


# Function to get the current running timer
def get_current_timer():
    try:
        result = subprocess.run(['/home/navin/.config/i3/scripts/timewarrior-status'], capture_output=True, text=True)
        return result.stdout.strip()
    except Exception as e:
        ui.notify(f'An error occurred while fetching the timer status: {e}', color='red')
        return ''


# List to store recent tags
recent_tags = get_recent_tags()


def toggle_timewarrior(tag=None):
    # Check the current status of Timewarrior
    try:
        # Get the current running timer
        result = subprocess.run(['timew', 'get', 'dom.active'], capture_output=True, text=True)
        if result.stdout.strip() == '0':
            # Start a new timer
            subprocess.run(['timew', 'start'])
            ui.notify('Timer started.')
        else:
            # Stop the current timer with the provided tag
            if tag:
                subprocess.run(['timew', 'tag', tag])
                subprocess.run(['timew', 'stop'])
                ui.notify(f'Timer stopped with tag: {tag}')
                # Add the tag to recent tags if it's not already there
                if tag not in recent_tags:
                    recent_tags.insert(0, tag)
            else:
                subprocess.run(['timew', 'stop'])
                ui.notify('Timer stopped without a tag.')
    except Exception as e:
        ui.notify(f'An error occurred: {e}', color='red')
    refresh_timer()


def refresh_timer():
    current_timer = get_current_timer()
    if current_timer:
        timer_label.set_text(current_timer)
    else:
        timer_label.set_text('No active timer.')


# NiceGUI application layout
ui.label('Timewarrior Timer Control').style('font-size: 24px; font-weight: bold;')

# Label to display the current timer
timer_label = ui.label(get_current_timer()).style('font-size: 18px;')
# Button to refresh the current timer
ui.button('Refresh Timer', on_click=refresh_timer)

# Select widget for tags with search functionality
tag_select = ui.select(
    label='Select or search for a tag (optional):',
    options=recent_tags[2:],
    with_input=True
).props(
    'clearable'
).style('width: 100%;')

# Button to toggle the timer
ui.button('Toggle Timer', on_click=lambda: toggle_timewarrior(tag_select.value))

# Run the NiceGUI application
ui.run()
