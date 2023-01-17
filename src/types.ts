export interface Stanza {
    idStanza: number,
    prezzoAnotte: string,
    imgStanza: any,
    tagliaStanza: string,
    tipologiaStanza: string
}

export interface Utente {
    idUtente: number,
    imgProfilo: string,
    nome: string,
    cognome: string,
    dataNascita: string,
    email: string
}

export interface Recensione{
    idRecensione: number,
    dataRecensione: string,
    testoRecensione: string,
    votoRecensione: string
}