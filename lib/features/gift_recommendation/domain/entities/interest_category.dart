class InterestCategory {
  final String name;
  final List<String> subCategories;

  const InterestCategory({required this.name, required this.subCategories});
}

const kInterestCategories = [
  InterestCategory(name: '운동, 스포츠', subCategories: ['축구', '야구', '농구', '배구', '헬스', '러닝']),
  InterestCategory(name: '게임',        subCategories: ['닌텐도', '모바일게임']),
  InterestCategory(name: '패션, 뷰티',  subCategories: ['패션', '메이크업', '향수', '악세서리', '스킨케어']),
  InterestCategory(name: '음악',        subCategories: ['K-POP', '힙합', '밴드', '악기연주']),
  InterestCategory(name: '문화, 엔터',  subCategories: ['애니', '만화', '공연', '뮤지컬']),
  InterestCategory(name: '여행',        subCategories: ['여행', '캠핑']),
  InterestCategory(name: '디지털',      subCategories: ['키보드', '전자기기']),
  InterestCategory(name: '자기계발',    subCategories: ['독서', '필기', '다이어리']),
  InterestCategory(name: '기타',        subCategories: []),
];
