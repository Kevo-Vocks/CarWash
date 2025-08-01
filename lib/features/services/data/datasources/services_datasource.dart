import 'package:car_wash/features/services/domain/entities/service.dart';

abstract class ServicesDataSource {
  Future<List<Service>> getServices(String carWashId);
}

class ServicesDataSourceImpl implements ServicesDataSource {
  final Map<String, List<Service>> _servicesMap = {
    '1': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1500.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2000.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3500.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1800.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2500.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
    '2': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1520.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 5500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 4500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 5000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2000.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3505.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1180.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2550.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 3050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 4000.0),
    ],
    '3': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1600.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 6500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3600.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3500.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1600.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2500.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3560.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3570.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1180.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2560.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1060.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2006.0),
    ],
    '4': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1700.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 5500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3500.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 6000.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3600.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 2180.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2570.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 2050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2300.0),
    ],
    '5': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1600.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2600.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2000.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3500.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 6180.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2500.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1650.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
    '6': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1000.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3000.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2500.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3500.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1800.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2500.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
    '7': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1900.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2000.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3590.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1800.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2500.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
    '8': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 1600.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2050.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 2500.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1800.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2500.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
    '9': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 2500.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2050.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 5500.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1800.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2500.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
    '10': [
      Service(id: '1', name: 'Exterior Car Washing', description: 'Thorough cleaning of the vehicle exterior.', price: 2500.0),
      Service(id: '2', name: 'Interior Vacuuming & Cleaning', description: 'Vacuum and clean interior surfaces.', price: 2500.0),
      Service(id: '3', name: 'Engine Cleaning', description: 'Degrease and clean engine bay.', price: 3500.0),
      Service(id: '4', name: 'Undercarriage Cleaning', description: 'Clean vehicle undercarriage.', price: 3000.0),
      Service(id: '5', name: 'Car Detailing', description: 'Complete interior and exterior detailing.', price: 1200.0),
      Service(id: '6', name: 'Air Purge (Dash & Console)', description: 'Clean and freshen air vents and dash.', price: 2000.0),
      Service(id: '7', name: 'Carpet Shampoo', description: 'Deep clean carpets and upholstery.', price: 3500.0),
      Service(id: '8', name: 'Seat & Upholstery Shampoo', description: 'Clean seats and upholstery fabrics.', price: 3500.0),
      Service(id: '9', name: 'Interior Detail', description: 'Detailed cleaning and conditioning of interior.', price: 1800.0),
      Service(id: '10', name: 'Full Detail', description: 'Complete interior and exterior detail.', price: 2600.0),
      Service(id: '11', name: 'Mobile Car Wash', description: 'Car wash service at your location.', price: 1050.0),
      Service(id: '12', name: '24-Hour Car Wash', description: 'Car wash available 24/7.', price: 2000.0),
    ],
  };

  @override
  Future<List<Service>> getServices(String carWashId) async {
    print('ServicesDataSourceImpl: Fetching services for carWashId: $carWashId');
    final services = _servicesMap[carWashId] ?? [];
    if (services.isEmpty) {
      print('ServicesDataSourceImpl: No services found for carWashId: $carWashId');
    }
    return services;
  }
}