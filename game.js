// ============================================================
// CONSTANTS
// ============================================================

const SKIN_TONES = [
  '#FFDDC1','#F5CBA7','#E8A87C','#D4876C','#C06C5A','#A0522D','#7B3F00'
];

const HAIR_COLORS = [
  '#2C1810','#4A3728','#7B5B3A','#C9A96E','#F4D58D',
  '#E0E0E0','#FFFFFF','#FF6B9D','#FF4500','#7B61FF',
  '#00BCD4','#4CAF50','#1E40AF','#000000'
];

const EYE_COLORS = [
  '#5B7DB1','#4CAF50','#8B6914','#607D8B','#9C27B0','#1A1A1A'
];

const COLOR_PALETTE = [
  '#FF6B9D','#FF4B6E','#FF8C42','#FFD93D','#A8E063',
  '#06D6A0','#4ECDC4','#45B7D1','#7B61FF','#C77DFF',
  '#FF6B6B','#FFA07A','#FFE66D','#88D8B0','#88BBD6',
  '#FFFFFF','#E0E0E0','#9E9E9E','#424242','#1A1A1A',
  '#F5E6CA','#D4A5A5','#9BB7D4','#C4B7CB','#B5C4B1'
];

const HAIR_STYLES = [
  { id:'short',    name:'Short',    emoji:'💇' },
  { id:'medium',   name:'Medium',   emoji:'👱' },
  { id:'long',     name:'Long',     emoji:'🧝' },
  { id:'curly',    name:'Curly',    emoji:'🌀' },
  { id:'bun',      name:'Bun',      emoji:'🔴' },
  { id:'pigtails', name:'Pigtails', emoji:'🎀' },
];

const TOP_STYLES = [
  { id:'tshirt',  name:'T-Shirt',  emoji:'👕' },
  { id:'crop',    name:'Crop Top', emoji:'🔲' },
  { id:'hoodie',  name:'Hoodie',   emoji:'🧥' },
  { id:'dress',   name:'Dress',    emoji:'👗' },
  { id:'blouse',  name:'Blouse',   emoji:'🪡' },
  { id:'jacket',  name:'Jacket',   emoji:'🥼' },
];

const BOTTOM_STYLES = [
  { id:'jeans',      name:'Jeans',       emoji:'👖' },
  { id:'skirt',      name:'Skirt',       emoji:'👗' },
  { id:'shorts',     name:'Shorts',      emoji:'🩲' },
  { id:'leggings',   name:'Leggings',    emoji:'🦵' },
  { id:'wide_pants', name:'Wide Pants',  emoji:'🎋' },
];

const SHOE_STYLES = [
  { id:'sneakers', name:'Sneakers', emoji:'👟' },
  { id:'heels',    name:'Heels',    emoji:'👠' },
  { id:'boots',    name:'Boots',    emoji:'🥾' },
  { id:'sandals',  name:'Sandals',  emoji:'👡' },
  { id:'loafers',  name:'Loafers',  emoji:'🥿' },
];

const HAT_STYLES = [
  { id:'none',   name:'None',   emoji:'❌' },
  { id:'beanie', name:'Beanie', emoji:'🧢' },
  { id:'beret',  name:'Beret',  emoji:'🎩' },
  { id:'cap',    name:'Cap',    emoji:'🧢' },
  { id:'bow',    name:'Bow',    emoji:'🎀' },
  { id:'flower', name:'Flower', emoji:'🌸' },
];

const BAG_STYLES = [
  { id:'none',      name:'None',     emoji:'❌' },
  { id:'tote',      name:'Tote',     emoji:'👜' },
  { id:'backpack',  name:'Backpack', emoji:'🎒' },
  { id:'clutch',    name:'Clutch',   emoji:'👝' },
  { id:'crossbody', name:'Crossbody',emoji:'👛' },
];

const ACCESSORY_STYLES = [
  { id:'none',       name:'None',      emoji:'❌' },
  { id:'glasses',    name:'Glasses',   emoji:'👓' },
  { id:'sunglasses', name:'Sunglasses',emoji:'🕶️' },
  { id:'necklace',   name:'Necklace',  emoji:'📿' },
  { id:'earrings',   name:'Earrings',  emoji:'💎' },
  { id:'scarf',      name:'Scarf',     emoji:'🧣' },
];

const PATTERNS = [
  { id:'solid',   name:'Solid',   preview:'▬▬▬' },
  { id:'stripes', name:'Stripes', preview:'≡≡≡' },
  { id:'dots',    name:'Dots',    preview:'⠶⠶⠶' },
  { id:'checks',  name:'Checks',  preview:'▦▦▦' },
  { id:'floral',  name:'Floral',  preview:'✿✿✿' },
];

const HOUSE_ITEMS = [
  { id:'sofa',         name:'Sofa',         emoji:'🛋️', cost:20, w:2, h:1, cat:'seating'    },
  { id:'armchair',     name:'Armchair',     emoji:'💺', cost:12, w:1, h:1, cat:'seating'    },
  { id:'beanbag',      name:'Bean Bag',     emoji:'🪑', cost:8,  w:1, h:1, cat:'seating'    },
  { id:'bed',          name:'Bed',          emoji:'🛏️', cost:35, w:2, h:2, cat:'sleeping'   },
  { id:'coffee_table', name:'Coffee Table', emoji:'☕', cost:10, w:1, h:1, cat:'decor'      },
  { id:'desk',         name:'Desk',         emoji:'🖥️', cost:22, w:2, h:1, cat:'decor'      },
  { id:'wardrobe',     name:'Wardrobe',     emoji:'🚪', cost:30, w:1, h:2, cat:'storage'    },
  { id:'bookshelf',    name:'Bookshelf',    emoji:'📚', cost:15, w:1, h:2, cat:'storage'    },
  { id:'dresser',      name:'Dresser',      emoji:'🗄️', cost:20, w:1, h:1, cat:'storage'    },
  { id:'plant',        name:'Plant',        emoji:'🪴', cost:5,  w:1, h:1, cat:'decor'      },
  { id:'lamp',         name:'Floor Lamp',   emoji:'💡', cost:8,  w:1, h:1, cat:'decor'      },
  { id:'mirror',       name:'Mirror',       emoji:'🪞', cost:12, w:1, h:2, cat:'decor'      },
  { id:'painting',     name:'Painting',     emoji:'🖼️', cost:10, w:1, h:1, cat:'decor'      },
  { id:'rug',          name:'Rug',          emoji:'🔳', cost:15, w:2, h:2, cat:'decor'      },
  { id:'candles',      name:'Candles',      emoji:'🕯️', cost:6,  w:1, h:1, cat:'decor'      },
  { id:'tv',           name:'TV',           emoji:'📺', cost:25, w:2, h:1, cat:'appliances' },
  { id:'fridge',       name:'Fridge',       emoji:'🧊', cost:30, w:1, h:2, cat:'appliances' },
  { id:'bathtub',      name:'Bathtub',      emoji:'🛁', cost:40, w:2, h:1, cat:'appliances' },
  { id:'toilet',       name:'Toilet',       emoji:'🚽', cost:20, w:1, h:1, cat:'appliances' },
  { id:'microwave',    name:'Microwave',    emoji:'📦', cost:18, w:1, h:1, cat:'appliances' },
];

const GRID_COLS = 7;
const GRID_ROWS = 5;

// ============================================================
// GAME STATE
// ============================================================

function defaultOutfit() {
  return {
    skinColor: '#FDBCB4',
    hairColor: '#4A3728',
    hairStyle: 'long',
    eyeColor:  '#5B7DB1',
    top:    { color:'#FF9EBB', pattern:'solid', style:'tshirt'   },
    bottom: { color:'#7BAFD4', pattern:'solid', style:'jeans'    },
    shoes:  { color:'#FF7675', style:'sneakers' },
    hat:       { active:false, color:'#FFD93D', style:'beanie'   },
    bag:       { active:false, color:'#A29BFE', style:'tote'     },
    accessory: { active:false, color:'#FDCB6E', style:'glasses'  },
  };
}

let state = {
  coins: 0,
  designsSubmitted: 0,
  styleScore: 0,
  outfit: defaultOutfit(),
  working: defaultOutfit(),
  house: {
    wallColor: '#FFF9E6',
    floorType: 'wood',
    items: [],
    nextId: 1,
  },
  selectedShopItem: null,
  currentShopFilter: 'all',
};

// ============================================================
// PERSISTENCE
// ============================================================

function saveState() {
  try { localStorage.setItem('charsi', JSON.stringify(state)); } catch(e) {}
}

function loadState() {
  try {
    const s = localStorage.getItem('charsi');
    if (s) {
      const p = JSON.parse(s);
      state = Object.assign(state, p);
      state.working = JSON.parse(JSON.stringify(state.outfit));
    }
  } catch(e) {}
}

// ============================================================
// CHARACTER SVG GENERATION
// ============================================================

function patternDef(id, baseColor, pattern) {
  const lo = 'rgba(255,255,255,0.45)';
  const dk = 'rgba(0,0,0,0.12)';
  if (pattern === 'solid') return '';
  const bg = `<rect width="100%" height="100%" fill="${baseColor}"/>`;
  switch (pattern) {
    case 'stripes':
      return `<pattern id="${id}" patternUnits="userSpaceOnUse" width="12" height="12">
        ${bg}<line x1="-2" y1="14" x2="14" y2="-2" stroke="${lo}" stroke-width="4"/>
        <line x1="4" y1="16" x2="20" y2="0" stroke="${lo}" stroke-width="4"/>
      </pattern>`;
    case 'dots':
      return `<pattern id="${id}" patternUnits="userSpaceOnUse" width="14" height="14">
        ${bg}<circle cx="7" cy="7" r="3.5" fill="${lo}"/>
      </pattern>`;
    case 'checks':
      return `<pattern id="${id}" patternUnits="userSpaceOnUse" width="12" height="12">
        ${bg}<rect width="6" height="6" fill="${dk}"/>
        <rect x="6" y="6" width="6" height="6" fill="${dk}"/>
      </pattern>`;
    case 'floral':
      return `<pattern id="${id}" patternUnits="userSpaceOnUse" width="20" height="20">
        ${bg}
        <circle cx="10" cy="10" r="2.5" fill="${lo}"/>
        <circle cx="10" cy="6"  r="2"   fill="${lo}"/>
        <circle cx="10" cy="14" r="2"   fill="${lo}"/>
        <circle cx="6"  cy="10" r="2"   fill="${lo}"/>
        <circle cx="14" cy="10" r="2"   fill="${lo}"/>
      </pattern>`;
    default: return '';
  }
}

function fill(color, pattern, patId) {
  return pattern === 'solid' ? color : `url(#${patId})`;
}

function hairBackSVG(color, style) {
  switch (style) {
    case 'short':
      return `<ellipse cx="100" cy="55" rx="50" ry="46" fill="${color}"/>`;
    case 'medium':
      return `<ellipse cx="100" cy="55" rx="52" ry="52" fill="${color}"/>
        <rect x="48" y="80" width="18" height="60" rx="9" fill="${color}"/>
        <rect x="134" y="80" width="18" height="60" rx="9" fill="${color}"/>`;
    case 'long':
      return `<ellipse cx="100" cy="55" rx="52" ry="52" fill="${color}"/>
        <rect x="46" y="80" width="20" height="130" rx="10" fill="${color}"/>
        <rect x="134" y="80" width="20" height="130" rx="10" fill="${color}"/>`;
    case 'curly':
      return `<ellipse cx="100" cy="55" rx="54" ry="54" fill="${color}"/>
        <circle cx="52" cy="80"  r="14" fill="${color}"/>
        <circle cx="148" cy="80" r="14" fill="${color}"/>
        <circle cx="48" cy="105" r="13" fill="${color}"/>
        <circle cx="152" cy="105" r="13" fill="${color}"/>
        <circle cx="50" cy="130" r="12" fill="${color}"/>
        <circle cx="150" cy="130" r="12" fill="${color}"/>`;
    case 'bun':
      return `<ellipse cx="100" cy="60" rx="50" ry="48" fill="${color}"/>
        <circle cx="100" cy="12" r="22" fill="${color}"/>`;
    case 'pigtails':
      return `<ellipse cx="100" cy="60" rx="50" ry="48" fill="${color}"/>
        <circle cx="44"  cy="60" r="18" fill="${color}"/>
        <circle cx="156" cy="60" r="18" fill="${color}"/>
        <rect x="30"  y="68" width="18" height="90" rx="9" fill="${color}"/>
        <rect x="152" y="68" width="18" height="90" rx="9" fill="${color}"/>`;
    default:
      return `<ellipse cx="100" cy="55" rx="52" ry="52" fill="${color}"/>`;
  }
}

function hairFrontSVG(color, style) {
  const base = `<path d="M 50 58 Q 56 22 100 18 Q 144 22 150 58 Q 143 36 128 34 Q 114 32 100 34 Q 86 32 72 34 Q 57 36 50 58 Z" fill="${color}"/>
    <path d="M 50 58 Q 44 74 52 92 Q 47 80 54 66 Z" fill="${color}"/>
    <path d="M 150 58 Q 156 74 148 92 Q 153 80 146 66 Z" fill="${color}"/>`;
  if (style === 'bun') {
    return `${base}
      <path d="M 80 18 Q 100 10 120 18 Q 110 14 100 14 Q 90 14 80 18 Z" fill="${color}"/>`;
  }
  if (style === 'short') {
    return `<path d="M 52 60 Q 58 24 100 20 Q 142 24 148 60 Q 142 38 128 36 Q 114 34 100 36 Q 86 34 72 36 Q 58 38 52 60 Z" fill="${color}"/>`;
  }
  return base;
}

function eyesSVG(eyeColor, hairColor) {
  const lash = hairColor;
  const eye = (cx) => `
    <ellipse cx="${cx}" cy="72" rx="12" ry="13" fill="white"/>
    <ellipse cx="${cx}" cy="74" rx="8"  ry="9"  fill="${eyeColor}"/>
    <ellipse cx="${cx}" cy="74" rx="5"  ry="5.5"fill="#111"/>
    <circle  cx="${cx+3}" cy="70" r="2.5" fill="white"/>
    <path d="M ${cx-10} 62 Q ${cx} 56 ${cx+10} 62" stroke="${lash}" stroke-width="2" fill="none" stroke-linecap="round"/>`;
  return eye(82) + eye(118);
}

function generateCharSVG(o) {
  const {
    skinColor, hairColor, hairStyle, eyeColor,
    top, bottom, shoes, hat, bag, accessory
  } = o;

  const isDress = top.style === 'dress';
  const tpId = 'tp', bpId = 'bp';

  const topFill    = fill(top.color, top.pattern, tpId);
  const botFill    = isDress ? 'transparent' : fill(bottom.color, bottom.pattern, bpId);
  const shoeColor  = shoes.color;

  // Dress extends bottom area
  const dressExtra = isDress ? `
    <path d="M 46 230 Q 40 290 38 340 L 162 340 Q 160 290 154 230 Z" fill="${topFill}"/>` : '';

  // Bottom shape based on style
  let bottomSVG = '';
  if (!isDress) {
    if (bottom.style === 'skirt') {
      bottomSVG = `<path d="M 54 232 Q 46 290 42 345 L 158 345 Q 154 290 146 232 Z" fill="${botFill}"/>`;
    } else if (bottom.style === 'shorts') {
      bottomSVG = `
        <rect x="54" y="232" width="40" height="55" rx="5" fill="${botFill}"/>
        <rect x="106" y="232" width="40" height="55" rx="5" fill="${botFill}"/>`;
    } else {
      // jeans / leggings / wide_pants
      const legW = bottom.style === 'wide_pants' ? 42 : 34;
      const lx1 = 100 - legW - 6;
      const lx2 = 106;
      bottomSVG = `
        <rect x="${lx1}" y="232" width="${legW}" height="115" rx="${bottom.style==='leggings'?6:4}" fill="${botFill}"/>
        <rect x="${lx2}" y="232" width="${legW}" height="115" rx="${bottom.style==='leggings'?6:4}" fill="${botFill}"/>`;
    }
  }

  // Shoes
  let shoesSVG = '';
  if (shoes.style === 'heels') {
    shoesSVG = `
      <ellipse cx="74" cy="350" rx="22" ry="10" fill="${shoeColor}"/>
      <rect x="84" y="340" width="5" height="18" fill="${shoeColor}"/>
      <ellipse cx="126" cy="350" rx="22" ry="10" fill="${shoeColor}"/>
      <rect x="136" y="340" width="5" height="18" fill="${shoeColor}"/>`;
  } else if (shoes.style === 'boots') {
    shoesSVG = `
      <rect x="52" y="320" width="40" height="36" rx="8" fill="${shoeColor}"/>
      <rect x="108" y="320" width="40" height="36" rx="8" fill="${shoeColor}"/>
      <ellipse cx="72" cy="357" rx="24" ry="10" fill="${shoeColor}"/>
      <ellipse cx="128" cy="357" rx="24" ry="10" fill="${shoeColor}"/>`;
  } else if (shoes.style === 'sandals') {
    shoesSVG = `
      <ellipse cx="72" cy="350" rx="22" ry="9" fill="${shoeColor}"/>
      <line x1="60" y1="342" x2="84" y2="342" stroke="${shoeColor}" stroke-width="5" stroke-linecap="round"/>
      <ellipse cx="128" cy="350" rx="22" ry="9" fill="${shoeColor}"/>
      <line x1="116" y1="342" x2="140" y2="342" stroke="${shoeColor}" stroke-width="5" stroke-linecap="round"/>`;
  } else {
    shoesSVG = `
      <ellipse cx="72" cy="350" rx="24" ry="11" fill="${shoeColor}"/>
      <ellipse cx="72" cy="345" rx="18" ry="8"  fill="${shoeColor}"/>
      <ellipse cx="128" cy="350" rx="24" ry="11" fill="${shoeColor}"/>
      <ellipse cx="128" cy="345" rx="18" ry="8"  fill="${shoeColor}"/>`;
  }

  // Hat
  let hatSVG = '';
  if (hat.active && hat.style !== 'none') {
    const hc = hat.color;
    switch (hat.style) {
      case 'beanie':
        hatSVG = `
          <ellipse cx="100" cy="22" rx="52" ry="30" fill="${hc}"/>
          <rect x="48" y="42" width="104" height="14" rx="7" fill="${adjustBrightness(hc,-15)}"/>`;
        break;
      case 'beret':
        hatSVG = `
          <ellipse cx="100" cy="18" rx="55" ry="22" fill="${hc}"/>
          <circle cx="100" cy="16" r="6" fill="${adjustBrightness(hc,-20)}"/>`;
        break;
      case 'cap':
        hatSVG = `
          <ellipse cx="104" cy="26" rx="50" ry="26" fill="${hc}"/>
          <path d="M 50 38 Q 30 44 28 52 Q 40 50 56 46 Z" fill="${hc}"/>`;
        break;
      case 'bow':
        hatSVG = `
          <path d="M 72 22 Q 85 10 100 22 Q 85 18 72 22 Z" fill="${hc}"/>
          <path d="M 128 22 Q 115 10 100 22 Q 115 18 128 22 Z" fill="${hc}"/>
          <circle cx="100" cy="22" r="6" fill="${adjustBrightness(hc,-20)}"/>`;
        break;
      case 'flower':
        hatSVG = `
          <circle cx="100" cy="16" r="10" fill="${hc}"/>
          <circle cx="86"  cy="18" r="8"  fill="${hc}"/>
          <circle cx="114" cy="18" r="8"  fill="${hc}"/>
          <circle cx="100" cy="16" r="5"  fill="${adjustBrightness(hc,30)}"/>`;
        break;
    }
  }

  // Bag
  let bagSVG = '';
  if (bag.active && bag.style !== 'none') {
    const bc = bag.color;
    switch (bag.style) {
      case 'tote':
        bagSVG = `
          <rect x="150" y="188" width="36" height="44" rx="5" fill="${bc}"/>
          <path d="M 154 188 Q 155 172 162 170 Q 172 170 174 188" stroke="${bc}" stroke-width="4" fill="none"/>`;
        break;
      case 'backpack':
        bagSVG = `
          <rect x="148" y="148" width="34" height="50" rx="8" fill="${bc}"/>
          <rect x="153" y="162" width="24" height="24" rx="4" fill="${adjustBrightness(bc,-15)}"/>`;
        break;
      case 'clutch':
        bagSVG = `
          <rect x="152" y="200" width="36" height="24" rx="6" fill="${bc}"/>`;
        break;
      case 'crossbody':
        bagSVG = `
          <rect x="152" y="180" width="32" height="36" rx="6" fill="${bc}"/>
          <line x1="152" y1="184" x2="140" y2="148" stroke="${bc}" stroke-width="3"/>`;
        break;
    }
  }

  // Accessory
  let accSVG = '';
  if (accessory.active && accessory.style !== 'none') {
    const ac = accessory.color;
    switch (accessory.style) {
      case 'glasses':
        accSVG = `
          <rect x="70" y="67" width="26" height="18" rx="7" stroke="${ac}" stroke-width="2.5" fill="rgba(200,230,255,0.3)"/>
          <rect x="104" y="67" width="26" height="18" rx="7" stroke="${ac}" stroke-width="2.5" fill="rgba(200,230,255,0.3)"/>
          <line x1="96" y1="75" x2="104" y2="75" stroke="${ac}" stroke-width="2"/>
          <line x1="70" y1="73" x2="60" y2="70"  stroke="${ac}" stroke-width="2"/>
          <line x1="130" y1="73" x2="140" y2="70" stroke="${ac}" stroke-width="2"/>`;
        break;
      case 'sunglasses':
        accSVG = `
          <rect x="68" y="68" width="28" height="16" rx="6" stroke="${ac}" stroke-width="2.5" fill="${ac}" opacity="0.7"/>
          <rect x="104" y="68" width="28" height="16" rx="6" stroke="${ac}" stroke-width="2.5" fill="${ac}" opacity="0.7"/>
          <line x1="96" y1="75" x2="104" y2="75" stroke="${ac}" stroke-width="2"/>
          <line x1="68" y1="74" x2="58" y2="71"  stroke="${ac}" stroke-width="2"/>
          <line x1="132" y1="74" x2="142" y2="71" stroke="${ac}" stroke-width="2"/>`;
        break;
      case 'necklace':
        accSVG = `
          <path d="M 76 134 Q 100 148 124 134" stroke="${ac}" stroke-width="2.5" fill="none"/>
          <circle cx="100" cy="148" r="5" fill="${ac}"/>`;
        break;
      case 'earrings':
        accSVG = `
          <circle cx="54" cy="76" r="5" fill="${ac}"/>
          <line x1="54" y1="81" x2="54" y2="90" stroke="${ac}" stroke-width="2"/>
          <circle cx="54" cy="93" r="4" fill="${ac}"/>
          <circle cx="146" cy="76" r="5" fill="${ac}"/>
          <line x1="146" y1="81" x2="146" y2="90" stroke="${ac}" stroke-width="2"/>
          <circle cx="146" cy="93" r="4" fill="${ac}"/>`;
        break;
      case 'scarf':
        accSVG = `
          <path d="M 62 125 Q 100 140 138 125" stroke="${ac}" stroke-width="10" fill="none" stroke-linecap="round"/>
          <path d="M 90 125 Q 88 145 78 165" stroke="${ac}" stroke-width="10" fill="none" stroke-linecap="round"/>`;
        break;
    }
  }

  // Top clothing shape
  let topSVG = '';
  if (top.style === 'crop') {
    topSVG = `
      <path d="M 58 135 Q 50 142 48 160 L 48 202 Q 48 210 56 210 L 144 210 Q 152 210 152 202 L 152 160 Q 150 142 142 135 Z" fill="${topFill}"/>
      <rect x="26" y="134" width="28" height="68" rx="12" fill="${topFill}"/>
      <rect x="146" y="134" width="28" height="68" rx="12" fill="${topFill}"/>`;
  } else if (top.style === 'hoodie') {
    topSVG = `
      <path d="M 54 132 Q 46 140 44 158 L 44 248 Q 44 256 54 256 L 146 256 Q 156 256 156 248 L 156 158 Q 154 140 146 132 Z" fill="${topFill}"/>
      <rect x="22" y="132" width="32" height="90" rx="14" fill="${topFill}"/>
      <rect x="146" y="132" width="32" height="90" rx="14" fill="${topFill}"/>
      <path d="M 68 132 Q 100 122 132 132 Q 120 128 100 128 Q 80 128 68 132 Z" fill="${adjustBrightness(top.color,-15)}"/>`;
  } else if (top.style === 'jacket') {
    topSVG = `
      <path d="M 54 132 Q 46 140 44 158 L 44 248 Q 44 256 54 256 L 146 256 Q 156 256 156 248 L 156 158 Q 154 140 146 132 Z" fill="${topFill}"/>
      <rect x="22" y="132" width="32" height="90" rx="12" fill="${topFill}"/>
      <rect x="146" y="132" width="32" height="90" rx="12" fill="${topFill}"/>
      <line x1="100" y1="138" x2="100" y2="256" stroke="${adjustBrightness(top.color,-20)}" stroke-width="3"/>
      <rect x="80" y="180" width="36" height="20" rx="4" fill="${adjustBrightness(top.color,-10)}"/>`;
  } else if (top.style === 'blouse') {
    topSVG = `
      <path d="M 58 132 Q 50 140 48 158 L 48 248 Q 48 255 57 255 L 143 255 Q 152 255 152 248 L 152 158 Q 150 140 142 132 Z" fill="${topFill}"/>
      <rect x="26" y="132" width="28" height="84" rx="12" fill="${topFill}"/>
      <rect x="146" y="132" width="28" height="84" rx="12" fill="${topFill}"/>
      <path d="M 85 132 L 100 152 L 115 132" stroke="${adjustBrightness(top.color,-20)}" stroke-width="2" fill="none"/>`;
  } else {
    // tshirt / dress / default
    topSVG = `
      <path d="M 57 132 Q 48 140 46 158 L 46 248 Q 46 256 56 256 L 144 256 Q 154 256 154 248 L 154 158 Q 152 140 143 132 Z" fill="${topFill}"/>
      <rect x="24" y="132" width="30" height="80" rx="13" fill="${topFill}"/>
      <rect x="146" y="132" width="30" height="80" rx="13" fill="${topFill}"/>`;
  }

  return `
<defs>
  ${patternDef(tpId, top.color, top.pattern)}
  ${!isDress ? patternDef(bpId, bottom.color, bottom.pattern) : ''}
</defs>

<!-- Shadow -->
<ellipse cx="100" cy="358" rx="52" ry="8" fill="rgba(0,0,0,0.07)"/>

${shoesSVG}
${bottomSVG}
${dressExtra}
${topSVG}

<!-- Hands -->
<circle cx="36"  cy="218" r="12" fill="${skinColor}"/>
<circle cx="164" cy="218" r="12" fill="${skinColor}"/>

<!-- Neck -->
<rect x="88" y="116" width="24" height="20" rx="5" fill="${skinColor}"/>

${hairBackSVG(hairColor, hairStyle)}

<!-- Face -->
<ellipse cx="100" cy="64" rx="46" ry="50" fill="${skinColor}"/>

<!-- Ears -->
<ellipse cx="55"  cy="67" rx="9" ry="10" fill="${skinColor}"/>
<ellipse cx="145" cy="67" rx="9" ry="10" fill="${skinColor}"/>
<ellipse cx="55"  cy="67" rx="5" ry="6"  fill="${adjustBrightness(skinColor,-12)}"/>
<ellipse cx="145" cy="67" rx="5" ry="6"  fill="${adjustBrightness(skinColor,-12)}"/>

${eyesSVG(eyeColor, hairColor)}

<!-- Blush -->
<ellipse cx="70"  cy="84" rx="12" ry="8" fill="rgba(255,140,140,0.35)"/>
<ellipse cx="130" cy="84" rx="12" ry="8" fill="rgba(255,140,140,0.35)"/>

<!-- Nose -->
<path d="M 96 88 Q 100 95 104 88" stroke="${adjustBrightness(skinColor,-30)}" stroke-width="1.8" fill="none" stroke-linecap="round"/>

<!-- Mouth -->
<path d="M 88 100 Q 100 113 112 100" stroke="#D96060" stroke-width="2.5" fill="none" stroke-linecap="round"/>

${hairFrontSVG(hairColor, hairStyle)}
${hatSVG}
${accSVG}
${bagSVG}
`;
}

function adjustBrightness(hex, amount) {
  let r = parseInt(hex.slice(1,3),16);
  let g = parseInt(hex.slice(3,5),16);
  let b = parseInt(hex.slice(5,7),16);
  r = Math.max(0,Math.min(255, r+amount));
  g = Math.max(0,Math.min(255, g+amount));
  b = Math.max(0,Math.min(255, b+amount));
  return '#'+[r,g,b].map(v=>v.toString(16).padStart(2,'0')).join('');
}

function renderCharacter(svgEl, outfit) {
  svgEl.innerHTML = generateCharSVG(outfit);
}

// ============================================================
// UNIQUENESS / SCORING ALGORITHM
// ============================================================

function hexToHue(hex) {
  let r = parseInt(hex.slice(1,3),16)/255;
  let g = parseInt(hex.slice(3,5),16)/255;
  let b = parseInt(hex.slice(5,7),16)/255;
  const max = Math.max(r,g,b), min = Math.min(r,g,b);
  if (max===min) return 0;
  let h;
  if      (max===r) h = ((g-b)/(max-min)+6)%6*60;
  else if (max===g) h = ((b-r)/(max-min)+2)*60;
  else              h = ((r-g)/(max-min)+4)*60;
  return h;
}

function colorHarmony(hexList) {
  const hues = hexList.map(hexToHue);
  let best = 0;
  for (let i=0;i<hues.length;i++) {
    for (let j=i+1;j<hues.length;j++) {
      const d = Math.abs(hues[i]-hues[j]);
      const nd = Math.min(d, 360-d);
      if (nd>=150 && nd<=210) best = Math.max(best, 40);
      else if (nd>=90)        best = Math.max(best, 25);
      else if (nd>=30)        best = Math.max(best, 12);
    }
  }
  return best;
}

function scoreOutfit(o) {
  const breakdown = {};

  // 1. Color variety (0–50)
  const colorsUsed = [o.top.color, o.bottom.color, o.shoes.color];
  if (o.hat.active && o.hat.style!=='none')       colorsUsed.push(o.hat.color);
  if (o.bag.active && o.bag.style!=='none')       colorsUsed.push(o.bag.color);
  if (o.accessory.active && o.accessory.style!=='none') colorsUsed.push(o.accessory.color);
  const uniqueColors = new Set(colorsUsed).size;
  breakdown['Color Variety'] = Math.min(50, uniqueColors * 10);

  // 2. Color harmony (0–40)
  breakdown['Color Harmony'] = colorHarmony(colorsUsed);

  // 3. Pattern diversity (0–30)
  let patScore = 0;
  if (o.top.pattern !== 'solid')    patScore += 15;
  if (o.bottom.pattern !== 'solid' && o.bottom.pattern !== o.top.pattern) patScore += 15;
  breakdown['Pattern Variety'] = patScore;

  // 4. Accessories bonus (0–40)
  let accScore = 0;
  if (o.hat.active && o.hat.style!=='none')       accScore += 10;
  if (o.bag.active && o.bag.style!=='none')       accScore += 10;
  if (o.accessory.active && o.accessory.style!=='none') accScore += 10;
  if (o.hairStyle !== 'long')                     accScore += 10;
  breakdown['Accessory Bonus'] = accScore;

  // 5. Style diversity (0–20)
  const topPoints    = TOP_STYLES.findIndex(t=>t.id===o.top.style);
  const bottomPoints = BOTTOM_STYLES.findIndex(b=>b.id===o.bottom.style);
  const styleScore   = Math.min(20, (topPoints + bottomPoints) * 3);
  breakdown['Style Mix'] = styleScore;

  // 6. Rarity spark (0–20) — random flair
  const spark = Math.floor(Math.random() * 21);
  breakdown['Uniqueness Spark'] = spark;

  const total = Object.values(breakdown).reduce((a,b)=>a+b,0);
  return { total: Math.min(200, total), breakdown };
}

function scoreToStars(score) {
  if (score >= 180) return '⭐⭐⭐⭐⭐';
  if (score >= 140) return '⭐⭐⭐⭐☆';
  if (score >= 100) return '⭐⭐⭐☆☆';
  if (score >= 60)  return '⭐⭐☆☆☆';
  if (score >= 20)  return '⭐☆☆☆☆';
  return '☆☆☆☆☆';
}

function scoreToMessage(score) {
  if (score >= 180) return 'Absolutely iconic! Fashion royalty! 👑';
  if (score >= 160) return 'Stunning! You\'re a style legend! 🌟';
  if (score >= 140) return 'Amazing look! Heads will turn! 💫';
  if (score >= 120) return 'Really chic! Your style is on fire! 🔥';
  if (score >= 100) return 'Great outfit! Looking fabulous! ✨';
  if (score >= 80)  return 'Nice style! Keep experimenting!';
  if (score >= 60)  return 'Decent look! Try mixing more colors!';
  if (score >= 40)  return 'Getting there! Add more accessories!';
  return 'Keep designing — practice makes perfect!';
}

function scoreOutfitLive(o) {
  return scoreOutfit(o).total;
}

// ============================================================
// SCREEN MANAGEMENT
// ============================================================

function showScreen(name) {
  document.querySelectorAll('.screen').forEach(s => s.classList.remove('active'));
  document.querySelectorAll('.bnav').forEach(b => b.classList.remove('active'));
  document.getElementById('screen-'+name).classList.add('active');
  document.getElementById('bnav-'+name).classList.add('active');
  state.currentScreen = name;
  if (name === 'character') updateWardrobeScreen();
  if (name === 'clothing')  refreshDesigner();
  if (name === 'house')     refreshHouse();
}

// ============================================================
// SCREEN 1: WARDROBE
// ============================================================

function updateWardrobeScreen() {
  renderCharacter(document.getElementById('main-character'), state.outfit);
  document.getElementById('coin-display').textContent = state.coins;
  document.getElementById('stat-coins').textContent = state.coins;
  document.getElementById('stat-designs').textContent = state.designsSubmitted;
  document.getElementById('stat-house-items').textContent = state.house.items.length;

  const score = state.styleScore;
  document.getElementById('outfit-score-display').textContent = `Style Score: ${score} / 200`;
  document.getElementById('star-rating').textContent = scoreToStars(score);

  const topDef    = TOP_STYLES.find(t=>t.id===state.outfit.top.style);
  const bottomDef = BOTTOM_STYLES.find(b=>b.id===state.outfit.bottom.style);
  document.getElementById('outfit-name').textContent =
    `${topDef?.name || 'Top'} + ${bottomDef?.name || 'Bottom'}`;
}

// ============================================================
// SCREEN 2: CLOTHING DESIGNER
// ============================================================

function initDesigner() {
  buildItemGrid('top-styles-grid',    TOP_STYLES,       'top',       'style');
  buildItemGrid('bottom-styles-grid', BOTTOM_STYLES,    'bottom',    'style');
  buildItemGrid('shoes-styles-grid',  SHOE_STYLES,      'shoes',     'style');
  buildItemGrid('hair-styles-grid',   HAIR_STYLES,      'hair',      'hairStyle');
  buildItemGrid('hat-styles-grid',    HAT_STYLES,       'hat',       'style');
  buildItemGrid('bag-styles-grid',    BAG_STYLES,       'bag',       'style');
  buildItemGrid('acc-styles-grid',    ACCESSORY_STYLES, 'accessory', 'style');

  buildColorPalette('top-color-pal',    COLOR_PALETTE, 'top',    'color');
  buildColorPalette('bottom-color-pal', COLOR_PALETTE, 'bottom', 'color');
  buildColorPalette('shoes-color-pal',  COLOR_PALETTE, 'shoes',  'color');
  buildColorPalette('hair-color-pal',   HAIR_COLORS,   'hair',   'hairColor');
  buildColorPalette('skin-tone-pal',    SKIN_TONES,    'skin',   'skinColor');
  buildColorPalette('hat-color-pal',    COLOR_PALETTE, 'hat',    'color');
  buildColorPalette('bag-color-pal',    COLOR_PALETTE, 'bag',    'color');
  buildColorPalette('acc-color-pal',    COLOR_PALETTE, 'accessory', 'color');

  buildPatternGrid('top-pattern-grid',    'top');
  buildPatternGrid('bottom-pattern-grid', 'bottom');
}

function buildItemGrid(containerId, items, category, prop) {
  const el = document.getElementById(containerId);
  el.innerHTML = '';
  items.forEach(item => {
    const btn = document.createElement('button');
    btn.className = 'item-btn';
    btn.dataset.cat  = category;
    btn.dataset.prop = prop;
    btn.dataset.val  = item.id;
    btn.innerHTML = `<span class="item-emoji">${item.emoji}</span><span class="item-name">${item.name}</span>`;
    btn.onclick = () => selectOption(category, prop, item.id);
    el.appendChild(btn);
  });
}

function buildColorPalette(containerId, colors, category, prop) {
  const el = document.getElementById(containerId);
  el.innerHTML = '';
  colors.forEach(color => {
    const sw = document.createElement('div');
    sw.className = 'color-swatch';
    sw.style.background = color;
    sw.dataset.cat  = category;
    sw.dataset.prop = prop;
    sw.dataset.val  = color;
    sw.title = color;
    sw.onclick = () => selectOption(category, prop, color);
    el.appendChild(sw);
  });
}

function buildPatternGrid(containerId, category) {
  const el = document.getElementById(containerId);
  el.innerHTML = '';
  PATTERNS.forEach(p => {
    const btn = document.createElement('button');
    btn.className = 'pattern-btn';
    btn.dataset.cat = category;
    btn.dataset.val = p.id;
    btn.innerHTML = `<span class="pattern-preview">${p.preview}</span><span class="pattern-name">${p.name}</span>`;
    btn.onclick = () => selectOption(category, 'pattern', p.id);
    el.appendChild(btn);
  });
}

function selectOption(category, prop, value) {
  const w = state.working;

  if (category === 'skin')  { w.skinColor = value; }
  else if (category === 'hair') {
    if (prop === 'hairColor') w.hairColor = value;
    else if (prop === 'hairStyle') w.hairStyle = value;
  }
  else if (['hat','bag','accessory'].includes(category)) {
    if (prop === 'style') {
      w[category].style  = value;
      w[category].active = value !== 'none';
    } else {
      w[category][prop] = value;
    }
  }
  else if (w[category] !== undefined) {
    if (prop === 'style' || prop === 'color' || prop === 'pattern') {
      w[category][prop] = value;
    }
  }

  refreshSelectionHighlights();
  renderCharacter(document.getElementById('preview-character'), state.working);
  updatePotential();
}

function refreshSelectionHighlights() {
  const w = state.working;

  // Item buttons
  document.querySelectorAll('.item-btn').forEach(btn => {
    const cat  = btn.dataset.cat;
    const prop = btn.dataset.prop;
    const val  = btn.dataset.val;
    let current;
    if (cat === 'hair' && prop === 'hairStyle') current = w.hairStyle;
    else if (['hat','bag','accessory'].includes(cat)) current = w[cat].style;
    else if (w[cat]) current = w[cat][prop];
    btn.classList.toggle('selected', current === val);
  });

  // Color swatches
  document.querySelectorAll('.color-swatch').forEach(sw => {
    const cat  = sw.dataset.cat;
    const prop = sw.dataset.prop;
    const val  = sw.dataset.val;
    let current;
    if (cat === 'skin')  current = w.skinColor;
    else if (cat === 'hair' && prop === 'hairColor') current = w.hairColor;
    else if (['hat','bag','accessory'].includes(cat)) current = w[cat].color;
    else if (w[cat]) current = w[cat][prop];
    sw.classList.toggle('selected', current === val);
  });

  // Pattern buttons
  document.querySelectorAll('.pattern-btn').forEach(btn => {
    const cat = btn.dataset.cat;
    const val = btn.dataset.val;
    let current = w[cat]?.pattern;
    btn.classList.toggle('selected', current === val);
  });
}

function updatePotential() {
  const score = scoreOutfitLive(state.working);
  document.getElementById('potential-coins').textContent = score;
  document.getElementById('potential-bar').style.width = (score/200*100)+'%';
}

function refreshDesigner() {
  state.working = JSON.parse(JSON.stringify(state.outfit));
  renderCharacter(document.getElementById('preview-character'), state.working);
  refreshSelectionHighlights();
  updatePotential();
}

function switchTab(el, cat) {
  document.querySelectorAll('.dtab').forEach(t => t.classList.remove('active'));
  document.querySelectorAll('.dsec').forEach(s => s.classList.remove('active'));
  el.classList.add('active');
  document.getElementById('dsec-'+cat).classList.add('active');
}

function submitDesign() {
  const { total, breakdown } = scoreOutfit(state.working);
  state.outfit = JSON.parse(JSON.stringify(state.working));
  state.coins += total;
  state.designsSubmitted++;
  state.styleScore = total;

  // Update coin display
  document.getElementById('coin-display').textContent = state.coins;
  document.getElementById('shop-coin-display').textContent = state.coins;

  showReward(total, breakdown);
  saveState();
}

// ============================================================
// REWARD MODAL
// ============================================================

function showReward(coins, breakdown) {
  document.getElementById('reward-amount').textContent = coins;
  document.getElementById('reward-msg').textContent = scoreToMessage(coins);

  const bdEl = document.getElementById('reward-breakdown');
  bdEl.innerHTML = Object.entries(breakdown)
    .filter(([,v])=>v>0)
    .map(([k,v])=>`<div class="bd-row"><span>${k}</span><span class="bd-plus">+${v} 🪙</span></div>`)
    .join('');

  document.getElementById('reward-overlay').classList.remove('hidden');
}

function closeReward() {
  document.getElementById('reward-overlay').classList.add('hidden');
  showScreen('character');
}

// ============================================================
// SCREEN 3: HOUSE DESIGNER
// ============================================================

let currentShopFilter = 'all';

function refreshHouse() {
  renderRoomGrid();
  renderShop();
  document.getElementById('shop-coin-display').textContent = state.coins;
  // Apply wall + floor
  applyWallColor(state.house.wallColor);
  applyFloor(state.house.floorType);
  // Sync wall select
  const ws = document.getElementById('wall-select');
  if (ws) ws.value = state.house.wallColor;
}

function renderRoomGrid() {
  const grid = document.getElementById('room-grid');

  // Build occupation map
  const occupied = new Set();
  state.house.items.forEach(item => {
    const def = HOUSE_ITEMS.find(h=>h.id===item.type);
    if (!def) return;
    for (let dc=0; dc<def.w; dc++) {
      for (let dr=0; dr<def.h; dr++) {
        occupied.add(`${item.col+dc},${item.row+dr}`);
      }
    }
  });

  grid.innerHTML = '';

  // Cells
  for (let r=0; r<GRID_ROWS; r++) {
    for (let c=0; c<GRID_COLS; c++) {
      const cell = document.createElement('div');
      cell.className = 'room-cell';
      cell.dataset.col = c;
      cell.dataset.row = r;
      if (occupied.has(`${c},${r}`)) cell.classList.add('blocked');
      cell.addEventListener('click', ()=>handleRoomClick(c,r));
      cell.addEventListener('mouseenter', ()=>previewPlacement(c,r));
      cell.addEventListener('mouseleave', ()=>clearPreview());
      grid.appendChild(cell);
    }
  }

  // Placed items (absolute positioning over grid)
  const gridRect = grid.getBoundingClientRect ? null : null;
  state.house.items.forEach(item => {
    const def = HOUSE_ITEMS.find(h=>h.id===item.type);
    if (!def) return;
    const el = document.createElement('div');
    el.className = 'placed-item';

    // Use CSS grid positioning
    el.style.cssText = `
      grid-column: ${item.col+1} / span ${def.w};
      grid-row:    ${item.row+1} / span ${def.h};
      position: relative;
    `;
    el.innerHTML = `
      <span class="pi-emoji">${def.emoji}</span>
      <div class="pi-x" onclick="removeItem(${item.uid})">✕</div>
    `;
    grid.appendChild(el);
  });
}

function previewPlacement(c, r) {
  if (!state.selectedShopItem) return;
  const def = HOUSE_ITEMS.find(h=>h.id===state.selectedShopItem);
  if (!def) return;
  clearPreview();
  for (let dc=0; dc<def.w; dc++) {
    for (let dr=0; dr<def.h; dr++) {
      const cell = document.querySelector(`.room-cell[data-col="${c+dc}"][data-row="${r+dr}"]`);
      if (cell) cell.classList.add('highlight');
    }
  }
}

function clearPreview() {
  document.querySelectorAll('.room-cell.highlight').forEach(c=>c.classList.remove('highlight'));
}

function handleRoomClick(c, r) {
  if (!state.selectedShopItem) return;
  const def = HOUSE_ITEMS.find(h=>h.id===state.selectedShopItem);
  if (!def) return;

  if (state.coins < def.cost) {
    alert(`Not enough coins! Need ${def.cost} 🪙, you have ${state.coins} 🪙`);
    return;
  }

  // Check bounds
  if (c + def.w > GRID_COLS || r + def.h > GRID_ROWS) {
    alert("That item doesn't fit here!");
    return;
  }

  // Check occupied
  const occupied = new Set();
  state.house.items.forEach(item => {
    const d = HOUSE_ITEMS.find(h=>h.id===item.type);
    if (!d) return;
    for (let dc=0;dc<d.w;dc++) for (let dr=0;dr<d.h;dr++) occupied.add(`${item.col+dc},${item.row+dr}`);
  });

  for (let dc=0; dc<def.w; dc++) {
    for (let dr=0; dr<def.h; dr++) {
      if (occupied.has(`${c+dc},${r+dr}`)) {
        alert('That space is already occupied!');
        return;
      }
    }
  }

  // Place item
  state.coins -= def.cost;
  state.house.items.push({ uid: state.house.nextId++, type: def.id, col: c, row: r });
  state.selectedShopItem = null;

  document.getElementById('coin-display').textContent = state.coins;
  document.getElementById('shop-coin-display').textContent = state.coins;
  document.getElementById('place-hint').textContent = 'Tap an item to select, then tap a cell in the room to place it';

  document.querySelectorAll('.shop-item').forEach(el => el.classList.remove('selected'));

  renderRoomGrid();
  renderShop();
  saveState();
}

function removeItem(uid) {
  const idx = state.house.items.findIndex(i=>i.uid===uid);
  if (idx === -1) return;
  const item = state.house.items[idx];
  const def  = HOUSE_ITEMS.find(h=>h.id===item.type);
  // Refund half
  const refund = Math.floor((def?.cost||0)/2);
  state.coins += refund;
  state.house.items.splice(idx,1);
  document.getElementById('coin-display').textContent = state.coins;
  document.getElementById('shop-coin-display').textContent = state.coins;
  renderRoomGrid();
  renderShop();
  saveState();
}

function renderShop() {
  const grid = document.getElementById('shop-grid');
  grid.innerHTML = '';
  const filter = currentShopFilter;

  const visible = HOUSE_ITEMS.filter(item =>
    filter === 'all' ||
    filter === 'sleeping' && item.cat === 'sleeping' ||
    item.cat === filter
  );

  visible.forEach(item => {
    const el = document.createElement('div');
    el.className = 'shop-item';
    if (state.coins < item.cost) el.classList.add('cant-afford');
    if (state.selectedShopItem === item.id) el.classList.add('selected');
    el.innerHTML = `
      <span class="si-emoji">${item.emoji}</span>
      <span class="si-name">${item.name}</span>
      <span class="si-cost">🪙 ${item.cost}</span>
    `;
    if (state.coins >= item.cost) {
      el.onclick = () => selectShopItem(item.id);
    }
    grid.appendChild(el);
  });
}

function selectShopItem(id) {
  state.selectedShopItem = id;
  const def = HOUSE_ITEMS.find(h=>h.id===id);
  document.getElementById('place-hint').textContent =
    `${def.emoji} ${def.name} selected (${def.w}×${def.h}) — tap the room to place it`;
  renderShop();
}

function filterShop(cat, el) {
  currentShopFilter = cat;
  document.querySelectorAll('.scat').forEach(b=>b.classList.remove('active'));
  el.classList.add('active');
  state.selectedShopItem = null;
  renderShop();
}

function changeWall(color) {
  state.house.wallColor = color;
  applyWallColor(color);
  saveState();
}

function applyWallColor(color) {
  const grid = document.getElementById('room-grid');
  if (grid) grid.style.setProperty('--wall', color);
  // Apply as background of parent
  const section = document.querySelector('.room-section');
  if (section) section.style.background = color;
}

function changeFloor(type, el) {
  state.house.floorType = type;
  applyFloor(type);
  document.querySelectorAll('.fbtn').forEach(b=>b.classList.remove('active'));
  if (el) el.classList.add('active');
  saveState();
}

function applyFloor(type) {
  const grid = document.getElementById('room-grid');
  if (!grid) return;
  grid.className = 'room-grid floor-' + type;
}

function clearRoom() {
  if (!confirm('Remove all items? (You\'ll get a refund for half the cost)')) return;
  let refund = 0;
  state.house.items.forEach(item => {
    const def = HOUSE_ITEMS.find(h=>h.id===item.type);
    refund += Math.floor((def?.cost||0)/2);
  });
  state.house.items = [];
  state.coins += refund;
  document.getElementById('coin-display').textContent = state.coins;
  document.getElementById('shop-coin-display').textContent = state.coins;
  renderRoomGrid();
  renderShop();
  saveState();
}

// ============================================================
// INITIALIZE
// ============================================================

function init() {
  loadState();
  state.working = JSON.parse(JSON.stringify(state.outfit));
  initDesigner();
  updateWardrobeScreen();
  applyWallColor(state.house.wallColor);
  applyFloor(state.house.floorType);
}

init();
