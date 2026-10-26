package entity;





public enum BloodGroup {
    A_PLUS("A+"),
    A_MINUS("A-"),
    B_PLUS("B+"),
    B_MINUS("B-"),
    AB_PLUS("AB+"),
    AB_MINUS("AB-"),
    O_PLUS("O+"),
    O_MINUS("O-");

    private final String label;

    BloodGroup(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static BloodGroup fromLabel(String label) {
        for (BloodGroup group : values()) {
            if (group.getLabel().equals(label)) {
                return group;
            }
        }

        throw new IllegalArgumentException("Invalid blood group: " + label);
    }
}

