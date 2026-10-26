package service;




import dao.DonorDAO;
import entity.AvailabilityStatus;
import entity.BloodGroup;
import entity.Donor;
import entity.DonorStatus;
import entity.User;

public class DonorService {

    private final DonorDAO donorDAO = new DonorDAO();

    // Register a new donor
    public String registerDonor(
            Integer userId,
            String bloodGroupValue,
            String phone,
            String college,
            String consentValue) {

        if (userId == null) {
            return "Please log in before registering as a donor.";
        }

        if (bloodGroupValue == null || bloodGroupValue.trim().isEmpty()) {
            return "Please select your blood group.";
        }

        if (phone == null || !phone.trim().matches("[0-9+()\\- ]{7,20}")) {
            return "Please enter a valid contact number.";
        }

        if (college == null || college.trim().length() < 2
                || college.trim().length() > 150) {
            return "Please enter a valid college name.";
        }

        if (!"true".equals(consentValue)) {
            return "Please give consent to be contacted about donation opportunities.";
        }

        BloodGroup bloodGroup;


        try {
            bloodGroup = BloodGroup.fromLabel(bloodGroupValue.trim());
        } catch (IllegalArgumentException e) {
            return "Please select a valid blood group.";
        }

        // Prevent duplicate donor profiles
        if (donorDAO.findByUserId(userId) != null) {
            return "You have already registered as a donor.";
        }

        User user = new User();
        user.setUserId(userId);

        Donor donor = new Donor();
        donor.setUser(user);
        donor.setBloodGroup(bloodGroup);
        donor.setPhone(phone.trim());
        donor.setCollege(college.trim());
        donor.setAvailabilityStatus(AvailabilityStatus.AVAILABLE);
        donor.setDonorStatus(DonorStatus.PENDING);
        donor.setConsentToContact(true);

        boolean saved = donorDAO.saveDonor(donor);

        if (saved) {
            return "SUCCESS";
        }

        return "Registration could not be completed. Please try again.";
    }

    // Retrieve a donor profile for the logged-in user
    public Donor getDonorByUserId(Integer userId) {

        if (userId == null) {
            return null;
        }

        return donorDAO.findByUserId(userId);
    }

    // Update contact and availability preferences
    public String updateDonor(
            Integer userId,
            String bloodGroupValue,
            String phone,
            String college,
            String availabilityValue,
            String consentValue) {

        if (userId == null) {
            return "Please log in before updating your profile.";
        }

        Donor existingDonor = donorDAO.findByUserId(userId);

        if (existingDonor == null) {
            return "Donor profile not found. Please register first.";
        }

        if (bloodGroupValue == null || bloodGroupValue.trim().isEmpty()) {
            return "Please select your blood group.";
        }

        if (phone == null || !phone.trim().matches("[0-9+()\\- ]{7,20}")) {
            return "Please enter a valid contact number.";
        }

        if (college == null || college.trim().length() < 2
                || college.trim().length() > 150) {
            return "Please enter a valid college name.";
        }

        BloodGroup bloodGroup;

        try {
            bloodGroup = BloodGroup.valueOf(
                    bloodGroupValue.trim().toUpperCase()
                            .replace("+", "_POSITIVE")
                            .replace("-", "_NEGATIVE")
            );
        } catch (IllegalArgumentException e) {
            return "Please select a valid blood group.";
        }

        AvailabilityStatus availabilityStatus;

        try {
            availabilityStatus = AvailabilityStatus.valueOf(
                    availabilityValue.trim().toUpperCase()
            );
        } catch (Exception e) {
            return "Please select a valid availability status.";
        }

        boolean consent = "true".equals(consentValue);

        if (!consent) {
            availabilityStatus = AvailabilityStatus.UNAVAILABLE;
        }

        existingDonor.setBloodGroup(bloodGroup);
        existingDonor.setPhone(phone.trim());
        existingDonor.setCollege(college.trim());
        existingDonor.setAvailabilityStatus(availabilityStatus);
        existingDonor.setConsentToContact(consent);

        boolean updated = donorDAO.updateDonor(existingDonor);

        if (updated) {
            return "SUCCESS";
        }

        return "Unable to update your donor profile. Please try again.";
    }
}
