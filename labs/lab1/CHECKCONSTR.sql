alter table CourierTable
add constraint chkAge CHECK(Age > 0)

alter table CourierTable
add constraint chkExp CHECK(Experience > -1)