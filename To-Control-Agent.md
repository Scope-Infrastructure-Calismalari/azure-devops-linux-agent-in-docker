To control all versions and programs which are wanted to be installed in agent image

1. Java:

   ```update-alternatives --list java```

   It shows all the installed jdk versions .

   - To see current Java version:

     ```java --version```

2. Maven:

   ```mvn --version```

3. NodeJS:

   ```ls -l /etc/alternatives/java```

4. Yarn:

   ```yarn check ```

5. Python:

   ```ls -1 /usr/bin/python* | grep '.*[2-3]\(.[0-9]\+\)\?$'```
