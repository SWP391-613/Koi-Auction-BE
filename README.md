![screencapture-localhost-4000-swagger-ui-index-html-2024-10-17-11_21_10](https://github.com/user-attachments/assets/6eb4f61d-2fc8-4334-9bdf-91fb31fc3c68)


# Error on auto increment id after apply a new migration
- Reason: Sequence is not updated after applying a new migration
```sql
--- Check the sequence 
SELECT * FROM information_schema.sequences WHERE sequence_name = 'auctions_id_seq';

--- Update the sequence
CREATE SEQUENCE auctions_id_seq START WITH 1 INCREMENT BY 1;

--- Set the sequence as the max id
SELECT setval('auctions_id_seq', (SELECT MAX(id) FROM auctions));
```