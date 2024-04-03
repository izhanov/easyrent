const images = Object.values(import.meta.glob('./*.{png,jpg,jpeg,PNG,JPEG}', { eager: true, as: 'url' }))

export default images
