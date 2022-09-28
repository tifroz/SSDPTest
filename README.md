# SSDPTest
A simplistic app to demonstrate issues with SSDP / Network framework. This app attempts an `SSDP` search on startup, and simply displays the status of the `NWConnectionGroup` used for the search

Scenario:

1. On the test device, install a 3rd party app that uses the `CocoaAsyncSocket` library to performs `SSDP` discovery.
2. Restart the test device to clear any existing 3rd party apps/processes
3. Run this test app on the device, the status should be `ready`
4. Kill the test app
5. Start the 3rd party app that uses the `CocoaAsyncSocket` library, then send it to the background (without killing it) after a few seconds
6. Start the test app, this time the status should be `failed` (`address already in use`)
7. Optionally, kill the test app + the 3rd party app, then start the test app again (status should be `ready`)


