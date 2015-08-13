#!/bin/bash

#
# Configs
#
  
  #Browsers (set to true if you want to use the sepcified browser)
    DO_CHROME=false
    DO_FIREFOX=false

  #Services
    DO_SERVICES=true
    SERVICES=(
      'mysql'
      'apache2'
    )  

################################################
# Browsers
################################################

#
# Google Chrome
#
# var CHROME_PROFILE = string (select Chrome profile to use for browser session created.  Leave as Default if you only have 1 profile)
# var CHROME_PAGES = array (enter the pages you would like to fire up when chrome is opened)
#
  CHROME_PROFILE="Default"
  CHROME_PAGES=(
    "https://www.google.com"
  )

  if [ "$DO_CHROME" = true ]; then
    echo "Starting Chrome...."
    # Loop through CHROME_PAGES - open them up in new tabs.
      for page in "${CHROME_PAGES[@]}"
      do
        google-chrome $page --profile-directory="${CHROME_PROFILE}"
      done
  fi
  
#
# FireFox
#
# var FIREFOX_PROFILE = string (select Chrome profile to use for browser session created.  Leave as Default if you only have 1 profile)
# var FIREFOX_PAGES = array (enter the pages you would like to fire up when chrome is opened)
#
  FIREFOX_PROFILE="default"
  FIREFOX_PAGES=(
    "https://www.google.com"
  )

  if [ "$DO_FIREFOX" = true ]; then
    echo "Starting FireFox...."
    # Loop through FIREFOX_PAGES - add to string, then fire up firefox and open each page in its own tab.
      PAGE_STR=""
      for page in "${FIREFOX_PAGES[@]}"
      do
        PAGE_STR+="${page} "
      done
      firefox -P "${FIREFOX_PROFILE}" ${PAGE_STR}
  fi


################################################
# SERVICES
################################################  
  if [ "$DO_SERVICES" = true ]; then
    echo "Checking Services...."
    for svc in "${SERVICES[@]}"
    do
      START_SVC=""
      if [ "$(ps -ef | grep -v grep | grep "${svc}" | wc -l)" = "0" ]; then
        echo "${svc} is not running.  Attempting to start..."
          sudo systemctl start ${svc}.service
        echo "${START_SVC}"
        echo "${svc} started..."
      else
        echo "${svc} is runnng...."
      fi
    done
  fi