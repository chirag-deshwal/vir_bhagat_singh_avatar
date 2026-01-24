export interface Chapter {
    id: string;
    title: string;
    year: string;
    content: string;
    details: string[];
}

export const storyChapters: Chapter[] = [
    {
        id: "early-life",
        title: "Childhood of a Rebel",
        year: "1907 – 1919",
        content: "Born into a Jat Sikh family deeply involved in revolutionary activities against the British Raj. As a child, Bhagat Singh spoke of growing guns in the fields so he could fight the British.",
        details: [
            "Date of Birth: September 28, 1907",
            "Place: Banga, Lyallpur District (Present-day Pakistan)",
            "Father: Kishan Singh (Independence Activist)",
            "Uncle: Ajit Singh (Founder of Bharat Mata Society)",
            "Influence: Grew up surrounded by Ghadar Party literature and stories of sacrifice."
        ]
    },
    {
        id: "revolutionary-spark",
        title: "The Revolutionary Spark",
        year: "1919 – 1923",
        content: "The Jallianwala Bagh massacre of 1919, where General Dyer ordered troops to fire on unarmed civilians, shattered Singh's faith in non-violence. He visited the blood-soaked ground and bottled the earth as a reminder.",
        details: [
            "Age at Massacre: 12 Years Old",
            "College: National College, Lahore (Founded by Lala Lajpat Rai)",
            "Activities: Joined the dramatics society, using plays to spread patriotism.",
            "Key Association: Avoided early marriage to dedicate his life to the motherland."
        ]
    },
    {
        id: "saunders-killing",
        title: "Avenging The Lion",
        year: "1928",
        content: "Protesting the Simon Commission, Lala Lajpat Rai died after a brutal lathi charge by the police. Seeking justice, Bhagat Singh and his associates plotted to kill James Scott but mistakenly killed John P. Saunders.",
        details: [
            "Target: James A. Scott (Superintendent of Police)",
            "Victim: John P. Saunders (Assistant Superintendent)",
            "Date: December 17, 1928",
            "Escape: Singh shaved his beard and cut his hair to evade capture, escaping to Calcutta."
        ]
    },
    {
        id: "assembly-bombing",
        title: "To Make the Deaf Hear",
        year: "1929",
        content: "To protest the repressive Public Safety Bill and Trade Disputes Bill, Singh and Batukeshwar Dutt threw non-lethal smoke bombs into the Central Legislative Assembly, shouting 'Inquilab Zindabad!'.",
        details: [
            "Date: April 8, 1929",
            "Philosophy: 'It takes a loud voice to make the deaf hear.'",
            "Action: Threw pamphlets and bombs into empty spaces to ensure no casualties.",
            "Arrest: Intentionally stayed to be arrested, using the trial to propagate revolutionary ideas."
        ]
    },
    {
        id: "hunger-strike",
        title: "The Battle in Jail",
        year: "1929 – 1930",
        content: "Inside Mianwali Jail, Singh observed discrimination between European and Indian prisoners. He led a historic hunger strike demanding political prisoner status, books, and better hygiene.",
        details: [
            "Duration: 116 Days",
            "Demands: Equality in food standards, access to newspapers, and books.",
            "Solidarity: Jatin Das, a fellow comrade, died after 63 days of fasting.",
            "Outcome: The strike garnered massive public support throughout India."
        ]
    },
    {
        id: "execution",
        title: "The Ultimate Sacrifice",
        year: "March 23, 1931",
        content: "Convicted in the Lahore Conspiracy Case, Bhagat Singh, Rajguru, and Sukhdev were sentenced to death. They walked to the gallows with a smile, singing 'Mera Rang De Basanti Chola', becoming immortal legends.",
        details: [
            "Execution Time: 7:30 PM (11 hours ahead of schedule)",
            "Place: Lahore Central Jail",
            "Last Wish: To finish reading 'Reminiscences of Lenin'.",
            "Reaction: Their cremation triggered nationwide protests and grief."
        ]
    }
];
