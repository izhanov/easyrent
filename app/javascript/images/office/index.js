const images = Object.values(import.meta.glob('./*.{png,jpg,svg,jpeg,PNG,JPEG}', { eager: true, as: 'url' }))

export default images
