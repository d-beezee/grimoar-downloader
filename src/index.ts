import { exec } from "child_process";
import express from "express";
import path from "path";

const app = express();
const port = 3000;

// Endpoint per eseguire lo script e servire il file
app.get("/download", (req, res) => {
  // Esegui lo script download.sh
  exec("./src/download.sh", (error, stdout, stderr) => {
    if (error) {
      console.error(`Errore nell'esecuzione dello script: ${error.message}`);
      return res.status(500).send("Errore nell'esecuzione dello script");
    }
    if (stderr) {
      console.error(`Stderr: ${stderr}`);
    }
    console.log(`Stdout: ${stdout}`);

    // Controlla che il file esista e lo invia
    res.download("app-debug.apk", "app-debug.apk", (err) => {
      if (err) {
        console.error(`Errore nel download: ${err.message}`);
        res.status(500).send("Errore nel download del file");
      }
    });
  });
});

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

// Avvia il server
app.listen(port, () => {
  console.log(`Server in ascolto su http://localhost:${port}`);
});
