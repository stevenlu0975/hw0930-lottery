package com.systex.lottery.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberRepository extends JpaRepository<Member, Integer> {
    
    @Query("select m from Member m where m.username = :username")
    Optional<Member> queryByUserName(@Param("username") String username);
}
