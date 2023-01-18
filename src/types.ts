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

export interface Prenotazione {
    idStanza: number,
    prezzoAnotte: string,
    imgStanza: any,
    tagliaStanza: string,
    tipologiaStanza: string,
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
    votoPulizia: string,
    votoRistorazione: string,
    votoAccoglienza: string
}

export interface Review{
    idUtente: number,
    imgProfilo: string,
    nome: string,
    cognome: string,
    dataNascita: string,
    email: string,
    idRecensione: number,
    dataRecensione: string,
    votoPulizia: string,
    votoRistorazione: string,
    votoAccoglienza: string
}