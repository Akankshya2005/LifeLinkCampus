package entity;




import jakarta.persistence.*;
import jakarta.persistence.Convert;
import java.time.LocalDateTime;

@Entity
@Table(name = "donors")
public class Donor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "donor_id")
    private Integer donorId;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Convert(converter = BloodGroupConverter.class)
    @Column(name = "blood_group", nullable = false)
    private BloodGroup bloodGroup;

    @Column(name = "phone", nullable = false, length = 20)
    private String phone;

    @Column(name = "college", nullable = false, length = 150)
    private String college;

    @Enumerated(EnumType.STRING)
    @Column(name = "availability_status", nullable = false)
    private AvailabilityStatus availabilityStatus =
            AvailabilityStatus.AVAILABLE;

    @Enumerated(EnumType.STRING)
    @Column(name = "donor_status", nullable = false)
    private DonorStatus donorStatus = DonorStatus.PENDING;

    @Column(name = "consent_to_contact", nullable = false)
    private boolean consentToContact;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", insertable = false, updatable = false)
    private LocalDateTime updatedAt;

    public Donor() {
    }

    public Integer getDonorId() {
        return donorId;
    }

    public void setDonorId(Integer donorId) {
        this.donorId = donorId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BloodGroup getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(BloodGroup bloodGroup) {
        this.bloodGroup = bloodGroup;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCollege() {
        return college;
    }

    public void setCollege(String college) {
        this.college = college;
    }

    public AvailabilityStatus getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(
            AvailabilityStatus availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public DonorStatus getDonorStatus() {
        return donorStatus;
    }

    public void setDonorStatus(DonorStatus donorStatus) {
        this.donorStatus = donorStatus;
    }

    public boolean isConsentToContact() {
        return consentToContact;
    }

    public void setConsentToContact(boolean consentToContact) {
        this.consentToContact = consentToContact;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
}


