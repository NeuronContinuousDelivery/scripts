export interface Env {
    publicUrl: string;
    host: string;
}

export const env: Env = {
    publicUrl: process.env.REACT_APP_WEB_PATH ? process.env.REACT_APP_WEB_PATH : '',
    host: process.env.REACT_APP_WEB_HOST ? process.env.REACT_APP_WEB_HOST : ''
};

console.log(process.env.REACT_APP_WEB_PATH, process.env.REACT_APP_WEB_HOST);