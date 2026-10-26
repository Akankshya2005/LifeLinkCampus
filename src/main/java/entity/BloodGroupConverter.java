package entity;



import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class BloodGroupConverter
        implements AttributeConverter<BloodGroup, String> {

    @Override
    public String convertToDatabaseColumn(BloodGroup bloodGroup) {
        return bloodGroup == null ? null : bloodGroup.getLabel();
    }

    @Override
    public BloodGroup convertToEntityAttribute(String databaseValue) {
        return databaseValue == null
                ? null
                : BloodGroup.fromLabel(databaseValue);
    }
}
