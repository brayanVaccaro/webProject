<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/brayanVaccaro/webProject">
    <img src="src/public/img/logo.png" alt="Logo" width="200">
  </a>

<h3 align="center">Astra</h3>

  <p align="center">
    Il sito dell'hotel Astra che si trova a Gallipoli, dove si può prenotare stanze e scrivere recensioni e controllare il proprio profilo e vedere tutte le recensioni scritte e tutte le prenotazioni eseguite
    <br />
    <a href="https://github.com/brayanVaccaro/webProject"><strong>Documento: »</strong></a>
    <br />
    <br />
    ·
    ·
  </p>
</div>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Indice:</summary>
  <ol>
    <li>
      <a href="#about-the-project">Il progetto:</a>
    </li>
    <li>
      <a href="#getting-started">Per Iniziare:</a>
      <ul>
        <li><a href="#installation">Installazione:</a></li>
      </ul>
    </li>
    <li><a href="#usage">Utilizzo</a></li>
    <li><a href="#roadmap">Passaggi da seguire</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- IL PROGETTO -->
## Il progetto:
<br />
<div align="center">
  <a href="https://github.com/brayanVaccaro/webProject">
    <img src="src/public/img/logo_transparent.png" alt="Logo" width="200">
  </a>
  <p align="center">
</div>
L'obbiettivo del progetto è quello di implementare una applicazione web in grado di scambiare dati con un DataBase in un server dando la possibilità di insere e visualizzando prenotazioni di stanze, e inserendo e visualizzando recensioni scritti dai clienti


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- PER INIZIARE -->
### installazione

1. Clone the repo
   ```
   git clone https://github.com/brayanVaccaro/webProject.git
   ```
2. Fill .envtemplate with your custom variables. Rename it in .env
3. build it:
   ```
   npm i
   npm run dev
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ESEMPI DI UTILIZZP -->
## Utilizzo
Per utilizzare il servizio eseguire il login, se invece non si ha un'utente eseguire la registrazione.
Senza eseguire la registrazione è possibile visualizzare la pagina Home e la pagina Cosa pensano di noi(recensioni), ma non è possibile inserirne una.
Dopo aver Eseguito il login è possibile notare dei piccoli cambiamenti nella pagina di Home, ed è possibile andare nella pagina Stanze Disponibili per eseguire una prenotazione. Andando nella pagina Cosa pensano di noi è anche possibile eseguire una recensione. E infine andando nella pagina Profilo è posssibile visualizzare i dati inseriti durante la registrazione, lo storico recensioni inserite e lo storico delle prenotazioni eseguite.


<div align="center">
  <a href="https://github.com/gerardocipriano/prenotiamo">
    <img src="src/public/img/menu.png" alt="Menu" height="500">
  </a>
</div>

Nella pagine Stanze disponibili è possibile selezionare la data di inizio del soggiorno, la data di fine del soggiorno e infine la "taglia" della stanza in base alla quantità di persone che alloggeranno. 
ARRIVATO QUIIIII
  

<div align="center">
  <a href="https://github.com/gerardocipriano/prenotiamo">
    <img src="src/public/img/prenota.png" alt="Prenota" height="500">
  </a>
</div>

Dalla pagina storico puoi vedere tutti gli ordini che hai inviato da quando ti sei registrato.

<div align="center">
  <a href="https://github.com/gerardocipriano/prenotiamo">
    <img src="src/public/img/storico.png" alt="Storico" height="500">
  </a>
</div>

### Utenti Ordinanti

Da utente Ordinante, ti è possibile visualizzare il tasto per inviare la lista degli ordini presenti nella pagina "Prenota".
Se sei autorizzato ad inviare ordini, oltre ai tasti citati qui sopra, puoi vedere nella barra di navigazione anche il tasto delega.
L'interfaccia ti offre la possibilità, nella prima parte, di inserire un ordine a nome di un altro collega; nella seconda parte puoi eliminare l'ordine di un collega selezionando il suo nome e poi cliccando sul tasto.
Quest'ultima azione è irreversibile.

<div align="center">
  <a href="https://github.com/gerardocipriano/prenotiamo">
    <img src="src/public/img/delega.png" alt="delega page" height="500">
  </a>
</div>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Utente Ristorante

Prenotiamo! mette a disposizione per la mensa un' interfaccia pratica e intuitiva per l'inserimento e/o la rimozione di piatti dal menù.
Nella prima parte puoi inserire il nuovo piatto, inserendo nome, prezzo e tipo di portata (antipasto, primo, secondo o pizza).
Nella seconda parte, puoi rimuovere piatti dal menù. Usare questa funzione solo se si intendere rimuovere <b>definitivamente</b> dal menù il piatto (da non usare  in caso di temporanea mancanza).
La funzionalità Aggiungi immagine è ancora in fase di sviluppo, verrà resa disponibili nelle future versioni dell'applicazione.

<div align="center">
  <a href="https://github.com/gerardocipriano/prenotiamo">
    <img src="src/public/img/inserimento.png" alt="Submit new dish page" height="500">
  </a>
</div>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

Mandatory features:
- [x] Design Mockup
- [x] Build DB & SQL instructions
- [x] Register & Login 
- [x] Write CSS
- [x] Render menù in the "Menù" page
- [x] Users can view their past orders
- [x] Users can close the order
- [x] Users can choose one dish of their choose from the menu
- [x] Assess accesibility
- [x] User Role Management


Optional featues:

- [X] Design Graphics
- [ ] Display username in the top of the page
- [ ] Back to top button
- [ ] Push notification to all logged in users when the order is sent to the restaurant
- [x] Admin user that can add more entries in the menu
- [x] Delegated user that can send the order and make order for other users
- [x] SMTP function using https://nodemailer.com/
- [x] Hosting the webserver on Netlify
- [x] Company entities

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Gerardo Cipriano - gerardo.cipriano@studio.unibo.it <br />

Massimiliano Battelli - massimilian.battelli@studio.unibo.it <br />


Project Link: [https://github.com/gerardocipriano/prenotiamo](https://github.com/gerardocipriano/prenotiamo)

<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- MARKDOWN LINKS & IMAGES -->
[license-url]: https://github.com/gerardocipriano/prenotiamoblob/master/LICENSE
[product-screenshot]: src/public/img/secondLogo.jpg
