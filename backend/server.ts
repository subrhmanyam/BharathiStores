import express, { Request, Response } from 'express';
import cors from 'cors';

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Interfaces
interface Category {
    id: string;
    name: string;
    imageUrl: string;
}

interface Product {
    id: string;
    name: string;
    description: string;
    price: number;
    imageUrl: string;
    categoryId: string;
    rating: number;
    isTrending: boolean;
}

// Mock Data
const BANNERS: string[] = [
  'https://picsum.photos/800/400?random=1', 
  'https://picsum.photos/800/400?random=2', 
  'https://picsum.photos/800/400?random=3'
];

const CATEGORIES: Category[] = [
  { id: '1', name: 'Books', imageUrl: '' },
  { id: '2', name: 'Diety', imageUrl: '' },
  { id: '3', name: 'Lighting & Aroma', imageUrl: '' },
  { id: '4', name: 'Offerings', imageUrl: '' },
  { id: '5', name: 'Wearbles', imageUrl: '' },
];

const TRENDING_PRODUCTS: Product[] = Array.from({ length: 5 }, (_, i) => ({
  id: `t${i}`,
  name: `Trending Item ${i + 1}`,
  description: 'Trending item description',
  price: 500 + (i * 50),
  imageUrl: '',
  categoryId: '1',
  rating: 4.8,
  isTrending: true,
}));

// Route to get Home Screen Content
app.get('/api/home', (req: Request, res: Response) => {
  res.json({
    banners: BANNERS,
    categories: CATEGORIES,
    trending: TRENDING_PRODUCTS
  });
});

// Route to get Products by Category
app.get('/api/products/:categoryId', (req: Request, res: Response) => {
  const { categoryId } = req.params;
  const category = CATEGORIES.find(c => c.id === categoryId);
  
  if (!category) {
    // Generate generic items if category not explicitly mocked
    const products: Product[] = Array.from({ length: 10 }, (_, i) => ({
      id: `${categoryId}_${i}`,
      name: `Item ${i + 1}`,
      description: `Description for Item ${i + 1}`,
      price: 100 + (i * 20),
      imageUrl: '',
      categoryId: categoryId,
      rating: 4.0,
      isTrending: false,
    }));
    return res.json(products);
  }

  // Generate specific items based on category name
  const products: Product[] = Array.from({ length: 10 }, (_, i) => ({
      id: `${category.id}_${i}`,
      name: `${category.name} Item ${i + 1}`,
      description: `Description for ${category.name} Item ${i + 1}`,
      price: 200 + (i * 50),
      imageUrl: '',
      categoryId: category.id,
      rating: 4.0 + (i * 0.1),
      isTrending: false
  }));
  
  res.json(products);
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
