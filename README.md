### README: Windows Update Fix Script

This batch script addresses common Windows Update failures, particularly **error 0x80d02002**, and related issues.

**Errors This Script Fixes:**
*   **0x80d02002**: Caused by Delivery Optimization and corrupted update components. The script resets components and forces Delivery Optimization into bypass mode.
*   **0x800f081f**: Often caused by a corrupted component store. The script resets the store and repairs system files.
*   **0x80070002 / 0x8007000D**: "File not found" or "Invalid data" errors. Fixed by clearing the corrupted SoftwareDistribution cache.
*   **Stuck at 0% downloads**: Primarily fixed by clearing the Delivery Optimization download queue and setting bypass mode.
*   **General update stalls and failures**: Addressed by resetting all Windows Update services and re-registering core DLLs.

**How It Works:**
The script stops critical services, deletes corrupted cache folders (including Delivery Optimization), re-registers essential update components, and configures the system to use BITS instead of Delivery Optimization for downloads.

**Usage:**
1.  Save the script as `FixUpdate.bat`.
2.  **Right-click and select "Run as administrator"**.
3.  **Restart your computer** after it finishes.

