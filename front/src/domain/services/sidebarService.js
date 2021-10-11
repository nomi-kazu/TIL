import { getSidebarJson } from '~/src/infra/sidebarJsonInfra'
import SidebarModel from "~/src/domain/models/sidebarModel"

const camelCase = (str) => {
  str = str.charAt(0).toLowerCase() + str.slice(1)
  return str.replace(/[-_ ](.)/g, (match, group) =>
    group.toUpperCase()
  )
}

const pascalCase = (str) => {
  const camel = camelCase(str)
  return camel.charAt(0).toUpperCase() + camel.slice(1)
}

/**
 * sibebar.jsonから必要なデータを取得する
 */
const getDatas = (name) => {
  const sidebarJson = getSidebarJson()
  const sidebar = new SidebarModel(sidebarJson.data[name], sidebarJson.items)
  return sidebar.concatData
}

const getComponentName = (data) =>
  data.event ? `${pascalCase(data.event)}SidebarListItem` : "BaseSidebarListItem"

/**
 * Componentをimportし、vue用のObjectを取得する
 *    BaseSidebarListItem: () => import('~/components/organisms/list/BaseSidebarListItem')
 *    HomeSidebarListItem: () => import('~/components/organisms/list/HomeSidebarListItem')
 */
const importComponents = (datas) => {
  return uniqComponentNames(datas).reduce(
    (obj, component) => ({
      ...obj,
      [component]: () => import(`~/components/organisms/list/${component}`),
    }), {}
  )
}

/**
 * 一意なコンポーネントの名前の配列を作る
 */
const uniqComponentNames = (datas) => [...new Set(datas.map((key) => getComponentName(key)))]

class SidebarService {
  constructor(name) {
    this.name = name
    this.datas = getDatas(name)
  }

  componentName(data) {
    return getComponentName(data)
  }

  get importComponents() {
    return importComponents(this.datas)
  }
};

export default SidebarService
