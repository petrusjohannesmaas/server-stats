# Server Performance Stats

### 🧠 Overview
`server-stats.sh` is a bash script to get basic stats for any Linux system *(CPU, RAM, Disk usage, etc.)*

**Other scripts in the repository:**
* `benchmark`: Run a basic benchmark test on your hardware. 
* `web-server-status`: Check if a specific set of web servers are currently up *(or down)* and create a log file. 

**Dependencies**:

`benchmark.sh` requires the "**sysbench**" and "**lshw**" packages to run.
```sh
sudo apt install sysbench lshw
```

---

### ⚡️ How to use the scripts

**Clone the repository**:
```shell
git clone https://github.com/petrusjohannesmaas/server-stats
cd server-stats
```

**Make a script executable**:
```shell
chmod +x the-script.sh
```

**Execute the script**:
```shell
./the-script.sh
```

---
