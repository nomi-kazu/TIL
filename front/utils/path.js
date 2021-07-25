/**
 * @see https://nodejs.org/docs/latest-v14.x/api/path.html
 */


 import { dirname, extname, basename } from 'path'

 /**
 * ディレクトリの配列を取得
 *
 * @param { String } p パス
 * @returns { String[] }
 */
export const getDirArr = (p) => {
  p = p.startsWith("/") ? p.slice(1) : p
  return dirname(p).split("/");
}

/**
 * 拡張子を取得
 * .gitignoreのような.から始まるファイル名はnull
 *
 * @param { String } p パス
 * @returns { String|null }
 * @example .cpp .js .ts .php
 */
export const getExt = (p) => extname(basename(p)) || null

/**
 * ディレクトリ名を取得
 *
 * @param { String } p パス
 * @returns { String|null }
 */
export const getDirname = (p) => isDir(p) ? basename(p) : null

/**
 * ファイル名を取得する
 *
 * @param { String } p パス
 * @returns { String }
 * @example index.html index.php dist.js .gitignore
 */
export const getFilename = (p) => isFile(p) ? basename(p) : null

/**
 * フォルダか
 *
 * @param { String } p パス
 * @returns { Boolean }
 */
export const isDir = (p) => !isFile(p)

/**
 * ファイル名か
 *
 * @param { String } p パス
 * @returns { Boolean }
 */
export const isFile = (p) => basename(p).includes('.')
