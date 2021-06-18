const hoursPast = (hours: number) => {
  const d = new Date()
  d.setHours(d.getHours() - hours)
  return d.toISOString().replace(/\.\d+Z/, 'Z')
}


const config: Config[] = [
  {
    name: 'USPS in inbox',
    search: {
      in: 'inbox',
      before: hoursPast(18),
      from: 'USPSInformeddelivery@informeddelivery.usps.com'
    },
    action: {
      archive: true,
      markRead: true
    }
  },
  {
    name: 'USPS not in inbox',
    search: {
      in: 'archive',
      isUnread: true,
      before: hoursPast(18),
      from: 'USPSInformeddelivery@informeddelivery.usps.com'
    },
    action: {
      markRead: true
    }
  }
]
export default config

type Config = {
  name: string,
  search: {
    in?: 'inbox' | 'archive',
    before?: string,
    from?: string,
    isUnread?: boolean
  },
  action: {
    archive?: boolean,
    markRead?: boolean
  }
}
