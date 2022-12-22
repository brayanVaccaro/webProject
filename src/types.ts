export interface Stanza {
    idStanze: number,
    numeroStanza: string,
    prezzoStanzaAnotte: string,
    imgStanza: any,
    utenti: any,
    Descrizione: string
}

export interface Persona {
    Nome: string,
    Cognome: string,
    CartaId: string,
    DataNascita: string,
    Bracciale: string
}

export interface Utente {
    idUtente: number
    username: string
    nome: string
    prenotazione: string
}