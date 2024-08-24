class MBTIType {
  String name;
  String description;

  MBTIType({required this.name, required this.description});

  static List<MBTIType> getAllPersonalityTypes() {
    return [
      MBTIType(
        name: "INFP - The Mediator",
        description: "INFPs are introspective, idealistic, and empathetic individuals who strive for a deeper understanding of themselves and others. They are creative and seek to express their individuality through art, writing, or other forms of self-expression. They value authenticity and are often seen as sensitive, caring, and open-minded.",
      ),
      MBTIType(
        name: "INFJ - The Advocate",
        description: "INFJs are insightful, principled, and deeply altruistic individuals. They have a strong sense of morality and a desire to make a positive impact on the world. INFJs are often reserved but passionate about their causes, and they are highly intuitive and empathetic.",
      ),
      MBTIType(
        name: "INTP - The Logician",
        description: "INTPs are innovative, analytical, and curious individuals who love to explore ideas and theories. They enjoy problem-solving and often think outside the box. INTPs are independent and value intellectual freedom, often engaging in abstract thinking and deep contemplation.",
      ),
      MBTIType(
        name: "INTJ - The Architect",
        description: "INTJs are strategic, logical, and highly independent thinkers. They are often seen as visionaries with a strong ability to plan and achieve their goals. INTJs are determined, confident, and have a natural inclination for leadership, often focusing on efficiency and long-term planning.",
      ),
      MBTIType(
        name: "ENFP - The Campaigner",
        description: "ENFPs are enthusiastic, creative, and sociable individuals who enjoy exploring new ideas and possibilities. They are highly empathetic and value deep connections with others. ENFPs are often driven by their passions and are known for their spontaneity and love of adventure.",
      ),
      MBTIType(
        name: "ENFJ - The Protagonist",
        description: "ENFJs are charismatic, altruistic, and inspiring individuals who are often seen as natural leaders. They have a strong desire to help others and are skilled at understanding and motivating those around them. ENFJs are warm, empathetic, and driven by their values.",
      ),
      MBTIType(
        name: "ENTP - The Debater",
        description: "ENTPs are quick-witted, energetic, and curious individuals who love to engage in debate and discussion. They enjoy challenging ideas and exploring different perspectives. ENTPs are innovative and thrive in environments that allow them to think creatively and independently.",
      ),
      MBTIType(
        name: "ENTJ - The Commander",
        description: "ENTJs are decisive, strategic, and confident leaders who excel in organizing and executing plans. They are goal-oriented and driven by results, often taking charge in situations that require strong leadership. ENTJs are logical, efficient, and highly ambitious.",
      ),
      MBTIType(
        name: "ISFP - The Adventurer",
        description: "ISFPs are sensitive, artistic, and spontaneous individuals who enjoy living in the moment. They are often drawn to creative pursuits and value personal freedom and self-expression. ISFPs are caring and empathetic, with a strong appreciation for beauty and aesthetics.",
      ),
      MBTIType(
        name: "ISFJ - The Defender",
        description: "ISFJs are loyal, practical, and compassionate individuals who are dedicated to helping others. They are often seen as reliable and hardworking, with a strong sense of duty and responsibility. ISFJs value tradition and are known for their attention to detail and meticulous nature.",
      ),
      MBTIType(
        name: "ISTP - The Virtuoso",
        description: "ISTPs are practical, observant, and adventurous individuals who enjoy hands-on activities and problem-solving. They are highly independent and value their freedom, often exploring new skills and hobbies. ISTPs are calm under pressure and are skilled at analyzing and troubleshooting issues.",
      ),
      MBTIType(
        name: "ISTJ - The Logistician",
        description: "ISTJs are responsible, methodical, and reliable individuals who value structure and organization. They are highly detail-oriented and prefer to work within established systems and procedures. ISTJs are known for their strong work ethic, integrity, and commitment to their responsibilities.",
      ),
      MBTIType(
        name: "ESFP - The Entertainer",
        description: "ESFPs are outgoing, spontaneous, and fun-loving individuals who enjoy being the center of attention. They are highly social and love to engage with others, often bringing energy and excitement to any situation. ESFPs are empathetic and value living life to the fullest.",
      ),
      MBTIType(
        name: "ESFJ - The Consul",
        description: "ESFJs are warm, caring, and sociable individuals who are dedicated to helping others. They are highly attuned to the needs of those around them and are often seen as supportive and nurturing. ESFJs value harmony and are skilled at organizing and coordinating social events.",
      ),
      MBTIType(
        name: "ESTP - The Entrepreneur",
        description: "ESTPs are energetic, action-oriented, and bold individuals who thrive in dynamic environments. They are natural risk-takers and enjoy living in the moment, often seeking out new challenges and experiences. ESTPs are practical and resourceful, with a strong focus on achieving tangible results.",
      ),
      MBTIType(
        name: "ESTJ - The Executive",
        description: "ESTJs are organized, efficient, and natural leaders who excel in managing people and resources. They are practical and results-driven, often taking charge in situations that require structure and discipline. ESTJs value tradition and are known for their strong sense of responsibility and duty.",
      ),
    ];
  }
}

